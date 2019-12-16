[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

Simple app to take webhooks from remote and pass them onto Wunderlist. Can be used with IFTTT to hook up a Google Home to Wunderlist, eg, 'Hey Google, add widgets to the shopping list'. 

Set the following Environment Variables on your Cloud Run project or just in your docker run command:

`KEY` : secret used to authenticate your requests from IFTTT to this app 

`CLIENT_ID` : Wunderlist client ID

`ACCESS_TOKEN` : Wunderlist access token

`LIST_ID` : the ID of the list you want to send items to