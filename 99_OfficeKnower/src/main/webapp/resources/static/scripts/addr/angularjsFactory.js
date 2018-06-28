var lang = new validateMessage("addr");

function init_addrFactory(app_id){


	app_id.directive('fileModel', ['$parse', function ($parse) {
		return {
			restrict: 'A',
			link: function(scope, element, attrs) {
				var model = $parse(attrs.fileModel);
				var modelSetter = model.assign;
				
				element.bind('change', function(){
					scope.$apply(function(){
						modelSetter(scope, element[0].files[0]);
					});
				});
			}
		};
	}]);

	app_id.config(function($httpProvider) {
	  $httpProvider.interceptors.push('jsonpInterceptor');
	})

	app_id.factory('jsonpInterceptor', function($timeout, $window, $q) {
	  return {
		'request': function(config) {
		  if (config.method === 'JSONP') {
			angular.callbacks.counter = 0;
			var callbackId = angular.callbacks.counter.toString(36);
			config.callbackName = 'angular_callbacks_' + callbackId;
			config.url = config.url.replace('JSON_CALLBACK', config.callbackName);
			$timeout(function() {
			  $window[config.callbackName] = angular.callbacks['_' + callbackId];
			}, 0, false);
		  }
		  return config;
		},

		'response': function(response) {
		  var config = response.config;
		  if (config.method === 'JSONP') {
			try {
				delete $window[config.callbackName]; // cleanup
			} catch (e) {
				$window[config.callbackName] = undefined;
			}
		  }
		  return response;
		},

		'responseError': function(rejection) {
		  var config = rejection.config;
		  if (config.method === 'JSONP') {
			try {
				delete $window[config.callbackName]; // cleanup
			} catch (e) {
				$window[config.callbackName] = undefined;
			}
		  }
		  return $q.reject(rejection);
		}
	  };
	})

	app_id.factory('Server', ['$http', function ($http) {
	  return {
		post: function(URL, DATA) {
			return $http({
				method: 'POST',
				url: URL ,
				headers: {'Content-Type': 'application/x-www-form-urlencoded'},
				data: $j.param(DATA)  
			});
		},

		jsonp: function(URL, PARAM) {
			return $http.jsonp(URL+PARAM)
		},

		uploadFileToUrl : function(file, uploadUrl){
			var fd = new FormData();
			fd.append('file', file);
			return $http.post(uploadUrl, fd, {
				transformRequest: angular.identity,
				headers: {'Content-Type': undefined}
			})
		}
	  };
	}]);

	app_id.factory('Useable', function () {	
	  return {
			checkBoxAllCkFnc : function(model, id){
				
				if($j('#'+id).is(':checked') == true){
					angular.forEach(model , function(value, key){	value.isChecked = 'Y';	});
				}else{
					angular.forEach(model , function(value, key){	value.isChecked = 'N';});
				}
			},
			
			checkBoxCkFnc : function(model , id){
				
				if($j('#'+id).is(':checked') == true){
					model.isChecked = 'Y';	
				}else{
					model.isChecked = 'N';
				}
			},

			NotYet : function (){
				alert(lang.getMessage("NOT_YET"));
			}
			
	  };
	});
/*
	app_id.factory('Pagination', ['Server', function(Server){
		this.itemsPerPage ;	 // 페이지당 몇개의 리스트가 나오는지 
		this.currentPage ; // 현재 페이지
		this.rangeSize; // 페이지네이션의 최대길이 
		this.totalPage; 
		this.pageArr;

		return {
			init : function( init_data ){
				this.itemsPerPage	= init_data.itemsPerPage;
				this.currentPage		= init_data.currentPage;
				this.rangeSize		= init_data.rangeSize -1 ;
				this.pageArr = [];

				if(init_data.totalCount  == 0 )
					this.totalPage = 1;
				else
					this.totalPage = Math.ceil(init_data.totalCount / this.itemsPerPage) ;
				
				//for(var i=1  ; i <= this.totalPage ; i++ ){this.pageArr.push(i) ; }
				for(var i= this.totalPage ; i > 0 ; i-- ){this.pageArr.push(i) ; }

			},

			prevPage : function ($_SCOPE) {
				
				if ( this.currentPage > 1) {	this.currentPage--;		}
				$_SCOPE.setPage(this.currentPage)
			},

			prev_10_Page : function ($_SCOPE) {
				
				if ( this.currentPage - 11  > 1  ) {	this.currentPage = this.currentPage - 10 ; 	}
				else{	this.currentPage = 1				}
				$_SCOPE.setPage(this.currentPage)
				
			},

			prev_go_1_Page : function ($_SCOPE) {
				this.currentPage = 1;
				$_SCOPE.setPage(this.currentPage);
			},

			nextPage : function ($_SCOPE) {
				if ( this.currentPage < ( this.totalPage  ) ) {	this.currentPage++;}
				$_SCOPE.setPage(this.currentPage)
			},

			next_10_Page : function ($_SCOPE) {
				if ( this.currentPage < ( this.totalPage -11 ) ){
					this.currentPage = this.currentPage + 10 ; 
				}else{
					this.currentPage = this.totalPage  ;
				}
				$_SCOPE.setPage(this.currentPage)
			},

			next_end_Page : function ($_SCOPE) {
				this.currentPage = this.totalPage  ;
				$_SCOPE.setPage(this.currentPage)
			},

			range : function () {
				var ret = [];
				var start;
				start = this.currentPage;

				if( this.rangeSize < this.totalPage ){
					if (start > this.totalPage - this.rangeSize) {
						start = this.totalPage - this.rangeSize ;
					}

					for (var i = start; i <= start + this.rangeSize; i++) {
						ret.push(i);
					}

				}else if ( this.totalPage == 1 ){
					start = 1 ;
					for (var i = start; i <= 1 ; i++) {
						ret.push(i);
					}
				}else{
					start = 1 ;
					for (var i = start; i <= this.totalPage ; i++) {
						ret.push(i);
					}
				}
				return ret;
			},

			setPage : function (n) {
				this.currentPage = parseInt(n);
			}
		};
	}]);
*/
}