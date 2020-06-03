# Rails & Warden

Using warden to protect a Rails API

A simple example of using just Warden without devise or any other complication for protecting a Rails API.

* a user can get a token by logging in.
* the user then sends this token on the out going requests to the server as entry in the header as 'Access-Token'
* Helper methods for protecting the API controllers and returning the `current_user`
* Warden Strategies for checking the tokens.
* another middleware for attaching the 'Access-Token' to some server responses. (handy if you want to change tokens regularly)
