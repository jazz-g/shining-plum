#!/usr/bin/env python3

from __future__ import print_function
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# Number to words generation
from inflect import engine

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

def main():
    """Shows basic usage of the Gmail API.
    Lists the user's Gmail labels.
    """
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    service = build('gmail', 'v1', credentials=creds)

    # Call the Gmail API
    results = service.users().labels().get(userId="me", id="INBOX").execute()
    # results is a dictionary that contains the overview for the inbox
    # gets number of new messages
    numUnread = results['messagesUnread']
    
    # generation of number to words
    ntwEngine = engine()
    wordnumUnread = ntwEngine.number_to_words(numUnread)
    # prints to stdout
    if numUnread == 0:
        print("You have no new emails.")
    elif numUnread == 1:
        print("You have one new email.")
    else:
        print("You have {num} new emails.".format(num=wordnumUnread))

if __name__ == '__main__':
    main()
