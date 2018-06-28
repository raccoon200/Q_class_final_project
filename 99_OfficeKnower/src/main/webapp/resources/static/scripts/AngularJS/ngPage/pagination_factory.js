(function() {
	'use strict';
	var m = angular.module('PageFactory', []);	
	
	m.factory('PageFactory', function() {

		this.itemsPerPage ;	 // 페이지당 몇개의 리스트가 나오는지 
		this.currentPage ; // 현재 페이지
		this.rangeSize; // 페이지네이션의 최대길이 
		this.totalPage; 
		this.pageArr;

		return {
			init : function( init_data ){
				this.itemsPerPage	= parseInt(init_data.itemsPerPage);
				this.currentPage		= parseInt(init_data.currentPage);
				this.rangeSize		= parseInt(init_data.rangeSize);
				this.pageArr = [];

				if(init_data.totalCount  == 0 )
					this.totalPage = 1;
				else
					this.totalPage = Math.ceil(init_data.totalCount / this.itemsPerPage) ;

				for(var i= this.totalPage ; i > 0 ; i-- ){this.pageArr.push(i) ; }

			},

			getValue : function (flag){
				return this[flag];
			},

			go_page : function($_SCOPE){
				if($_SCOPE.setPopUpPage != undefined ){
					$_SCOPE.setPopUpPage(this.currentPage)
				}else{
					$_SCOPE.setPage(this.currentPage)
				}
			},

			prevPage : function ($_SCOPE) {
				if ( this.currentPage > 1) {	this.currentPage--;		}
				this.go_page($_SCOPE);
			},

			prev_interval_Page : function ($_SCOPE) {
				if ( (Math.ceil(this.currentPage/ this.rangeSize) - 1 )* this.rangeSize   >  0   ) {	
					this.currentPage = (Math.ceil(this.currentPage/ this.rangeSize) - 1 )* this.rangeSize  ;
				}else{
					this.currentPage = 1;
				}
				this.go_page($_SCOPE);
			},

			prev_go_1_Page : function ($_SCOPE) {
				this.currentPage = 1;
				this.go_page($_SCOPE);
			},

			nextPage : function ($_SCOPE) {
				if ( this.currentPage < ( this.totalPage  ) ) {	this.currentPage++;}
				this.go_page($_SCOPE);
			},

			next_interval_Page : function ($_SCOPE) {
				if (  Math.ceil(this.currentPage/ this.rangeSize)* this.rangeSize + 1 < this.totalPage  ){
					this.currentPage = Math.ceil(this.currentPage/ this.rangeSize)* this.rangeSize + 1 ;
				}else{
					this.currentPage = this.totalPage  ;
				}
				this.go_page($_SCOPE);
			},

			next_end_Page : function ($_SCOPE) {
				this.currentPage = this.totalPage  ;
				this.go_page($_SCOPE);
			},


			paginationPopupButtonStyle  : function (){
				var currentPage =  this.currentPage;
				var rangeSize = this.rangeSize;
				var totalPage = this.totalPage;

				if(currentPage == 1){
					document.getElementById('goFirstPageFac').style.display = 'none';
					document.getElementById('goPrevIntervalPageFac').style.display = 'none';
				}else if (currentPage <= rangeSize ){
					document.getElementById('goFirstPageFac').style.display = '';
					document.getElementById('goPrevIntervalPageFac').style.display = 'none';
				}else if (currentPage > rangeSize){
					document.getElementById('goFirstPageFac').style.display = '';
					document.getElementById('goPrevIntervalPageFac').style.display = '';
				}

				if(currentPage == totalPage){
					document.getElementById('goNextIntervalPageFac').style.display = 'none';
					document.getElementById('goLastPageFac').style.display = 'none';
				}else if (currentPage < totalPage && currentPage > Math.floor(totalPage/rangeSize)*rangeSize ){
					document.getElementById('goNextIntervalPageFac').style.display = 'none';
					document.getElementById('goLastPageFac').style.display = '';
				}else if (currentPage < totalPage &&  currentPage <= Math.floor(totalPage/rangeSize)*rangeSize ){
					document.getElementById('goNextIntervalPageFac').style.display = '';
					document.getElementById('goLastPageFac').style.display = '';
				}
			},

			range : function () {
				var ret = [];
				var j = 1;
				var start;
				start = parseInt(this.currentPage);

				if( this.rangeSize < this.totalPage ){

					if (start > Math.floor(this.totalPage/this.rangeSize )*this.rangeSize ) {
						start = Math.floor(start/ this.rangeSize )* this.rangeSize +1  ;

						for (var i = start; i <= this.totalPage ; i++) {
							ret.push(i);
						}
					}else{
						start =  (Math.ceil( start/ this.rangeSize ) - 1 )* this.rangeSize ;

						while( j <= this.rangeSize ){
							ret.push( start+j );
							j++;
						}
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
	});
})();
