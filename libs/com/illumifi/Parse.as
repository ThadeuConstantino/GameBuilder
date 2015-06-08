﻿package com.illumifi {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	public class Parse {
		
		// --------------------------------------------------------------------
		// Constants
		// --------------------------------------------------------------------
		public static var api = '';
		public static const app = '';
		public static const key = '';
		public static const typ = 'application/json';
		
		
		// --------------------------------------------------------------------
		// Constructor
		// --------------------------------------------------------------------
		public function Parse() { 
			
		}
		
		
		// --------------------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------------------
		private static function Call(url:String, method:String, params:Object = null, where:Object = null, success:Function = null, error:Function = null):void { 
			
			var ldr:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(url);
			
			if (where != null) {
				if (params == null) { params = {}; }
				params['where'] = JSON.stringify(where); 
			}
			
			if (params != null) { 
				if (method == URLRequestMethod.GET) {
					var vars:URLVariables = new URLVariables();
					for (var p:String in params) {
						vars[p] = params[p];
					}
					req.data = vars;
				} else { 
					//params["email"] = "capacitacaozet@legozoom.com";
					//params["password"] = "48fa7ced";
					req.data = JSON.stringify(params); 
				}
			}
			req.contentType = Parse.typ;
			req.cacheResponse = false;
			req.method = method;
			req.useCache = false;
			req.requestHeaders.push(new URLRequestHeader('X-Parse-Application-Id', Parse.app));
			req.requestHeaders.push(new URLRequestHeader('X-Parse-REST-API-Key', Parse.key));
			
			if (success != null) { 
				ldr.addEventListener(Event.COMPLETE, function (e) {
					trace("**************************  "+e.target.data);
					var data = JSON.parse(e.target.data);
					success(data);
				}, false, 0, true);
			}
			if (error != null) { ldr.addEventListener(IOErrorEvent.IO_ERROR, error, false, 0, true); }
			
			// Debug -----------------> 
			ldr.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, function (resp) { 
				trace("DEBUG "+resp); 
			}, false, 0, true); 
			// <-----------------------
			
			ldr.load(req);
		}
		
		// --------------------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------------------
		public static function Delete(className:String, objectId:String, success:Function = null, error:Function = null):void {
			var url:String = Parse.api + className + '/' + objectId;
			Parse.Call(url, URLRequestMethod.DELETE, null, null, success, error);
		}
		
		public static function Get(className:String, params:Object = null, where:Object = null, success:Function = null, error:Function = null):void {
			var url:String = Parse.api +  className;
			Parse.Call(url, URLRequestMethod.GET, params, where, success, error);
		}
		
		public static function Post(className:String, params:Object = null, success:Function = null, error:Function = null):void {
			var url:String = Parse.api +  className;
			Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
		}
		public static function Put(className:String, objectId:String, params:Object = null, success:Function = null, error:Function = null):void {
			var url:String = Parse.api +  className + '/' + objectId;
			Parse.Call(url, URLRequestMethod.PUT, params, null, success, error);
		}
		
		public static function ResetPassword(email:String, success:Function = null, error:Function = null):void {
			var params:Object = {email: email};
			var url:String = Parse.api + 'requestPasswordReset';
			Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
		}
		
		public static function SignIn(username:String, password:String, success:Function = null, error:Function = null):void {
			var params:Object = {username: username, password: password};
			var url:String = Parse.api + 'login';
			Parse.Call(url, URLRequestMethod.GET, params, null, success, error);
		}
		
		public static function SignUp(username:String, password:String, success:Function = null, error:Function = null):void {
			var params:Object = {username: username, password: password};
			Parse.User.Post(params, success, error);
		}
		
		public static var User:Object = {
			Delete: function (objectId:String, success:Function = null, error:Function = null):void {
				var url:String = Parse.api + 'users/' + objectId;
				Parse.Call(url, URLRequestMethod.DELETE, null, null, success, error);
			},
			
			Get: function (objectId:String, success:Function = null, error:Function = null):void {
				var url:String = Parse.api + 'users/' + objectId;
				Parse.Call(url, URLRequestMethod.GET, null, null, success, error);
			},
			
			Post: function (params:Object, success:Function = null, error:Function = null):void {
				var url:String = Parse.api + 'users';
				Parse.Call(url, URLRequestMethod.POST, params, null, success, error);				
			},
			
			Put: function (objectId:String, params:Object, success:Function = null, error:Function = null):void {
				var url:String = Parse.api + 'users/' + objectId;
				Parse.Call(url, URLRequestMethod.PUT, params, null, success, error);
			},
			
			Search: function (where:Object, success:Function = null, error:Function = null):void {
				var url:String = Parse.api + 'users';
				Parse.Call(url, URLRequestMethod.GET, null, where, success, error);
			}
		}
		
		public static function Batch(requests:Array, success:Function, error:Function) {
			var params:Object = {requests: requests};
			var url:String = Parse.api + 'batch';
			Parse.Call(url, URLRequestMethod.POST, params, null, success, error);
		}
		
	}
}

