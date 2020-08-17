#!/usr/bin/env python3

from collections import deque
import feedparser
import pickle

class mergedFeed:
    def __init__(self):
        # You can have as many feeds as you like
        self.feedURLs = ["https://reddit.com/.rss"]
        self.feeds = []
        self.bookmark = []
        self.parseFeeds()
        self.loadQueue()
        self.updateQueue()
        self.makeBookmark()
        self.saveQueue()
    
    # Goes through each feed URL and tries to parse each feed and adds it to the parsed feed list
    def parseFeeds(self):
        for feed in self.feedURLs:
            self.feeds.append(feedparser.parse(feed))

    # rebuilds the queue if there is no existing feed    
    def rebuildQueue(self):
        self.q = deque([], maxlen = 8)
        self.makeBookmark()
        for item in self.bookmark:
            self.q.append(item)

    # saves the queue
    def saveQueue(self):
        pickle.dump(self.q, open("queue.pkl", "wb"))
        pickle.dump(self.bookmark, open("bookmark.pkl", "wb"))

    # tries to loads the queue, if it can't, it'll make one of the top entry in each feed. Over time it will update 
    def loadQueue(self):
        try:
            self.bookmark = pickle.load( open("bookmark.pkl", "rb"))
        except:
            self.makeBookmark()

        try: 
            self.q = pickle.load( open("queue.pkl", "rb"))
        except:
            self.rebuildQueue()

    # updates the Queue
    def updateQueue(self):
        for n in range(len(self.feeds)):
            i = 0
            for entry in self.feeds[n].entries:
                if entry.id == self.bookmark[n].id:
                    # slices and reverses list where we found the bookmarked entry. We don't increment i, so it doesn't add the same item twice
                    if i > 0:
                        for item in self.feeds[n].entries[i-1::-1]:
                            self.q.append(item)
                        break
                    else:
                        pass
                # edge case if the feed is a really fast updating feed and removed the placeholder article
                elif len(self.feeds[n].entries) == i-1:
                    for item in self.feeds[n].entries[::-1]:
                        self.q.append(item)
                else:
                    i += 1

    # Saves the first entry of each feed to the bookmark object
    def makeBookmark(self):
        self.bookmark = []
        for feed in self.feeds:
            self.bookmark.append(feed.entries[0])
    
    def printQueue(self):
        for item in list(self.q)[::-1]:
            print(item.title)



feed = mergedFeed()
feed.printQueue()
