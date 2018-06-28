var $j = jQuery.noConflict();


$j(function() {
    // iPad/iPhone hover problem
	/*
    $j('a').on('click touchend', function(e) {
        var el = $j(this);
        var link = el.attr('href');
        window.location = link;
    })
	*/
    // li > ul style
	/*
    var hasDepthList = $j('.mailbody ul li:has(ul)');
    hasDepthList.css({
        listStyle: 'none',
        display: 'inline'
    });
    */
    //skip navigation
    $j('.skip_menu a').click(function() {
        var cnt = $j('#contents');
        cnt.attr({tabIndex:-1}).focus();
    });

    //document click
    $j(document).click(function() {
        $j('.gnb_con').removeClass('show');
        $j('#gnb > a').removeClass('on');
        $j('.user_detail').removeClass('show');
        $j('.expand-menu').removeClass('show');
        $j('#showMoremenu').removeClass('hide');
    });

    //gnb open-close
    $j('.gnb').click(function(event) {
        event.stopPropagation();
        $j('.gnb_con').toggleClass('show');
        $j('#gnb > a').toggleClass('on');
    });
    $j('.logo').focusin(function(event) {
        $j('.gnb_con').removeClass('show');
        $j('#gnb > a').removeClass('on');
        $j('.expand-menu').removeClass('show');
        $j('#showMoremenu').removeClass('hide');
    });
    $j('.notice_icon').focusout(function(event) {
        $j('.gnb_con').removeClass('show');
        $j('#gnb > a').removeClass('on');
        $j('.expand-menu').removeClass('show');
        $j('#showMoremenu').removeClass('hide');
    });
    //gnb show-more
    $j('#showMoremenu').click(function(event){
        $j('.expand-menu').toggleClass('show');
        $j('#showMoremenu').toggleClass('hide');
    });
    $j('.gnb_con').click(function(event) {
        event.stopPropagation();
    });

    //trash icon
    $j('#spamMail, #trashMail').mouseenter(function(event) {
        $j(this).find('.trash').removeClass('hide');
        $j(this).find('.trash').addClass('show');
    });

    $j('#spamMail, #trashMail').mouseleave(function(event) {
        $j(this).find('.trash').addClass('hide');
        $j(this).find('.trash').removeClass('show');
    });
    //mail_setting_icon
    $j('#left_shared_sortable .label_box').mouseenter(function(event) {
        $j(this).parent().find('.mail_setting').removeClass('hide');
        $j(this).parent().find('.mail_setting').addClass('show');
    });

    $j('#left_shared_sortable .label_box').mouseleave(function(event) {
        $j(this).parent().find('.mail_setting').addClass('hide');
        $j(this).parent().find('.mail_setting').removeClass('show');
    });



    //launchpad height
   var lpHeight = $j('.launchpad > .menu_cir').height();
   $j('.launchpad').css('height', lpHeight+107+'px');

    //launchpad show-more

    var expandlpHeight = $j('.launchpad  .expand-launch').height();
    $j('#showMorelp').click(function(event){
        $j('.expand-launch').addClass('show');
        $j('#showMorelp').addClass('hide');
        $j('.launchpad').css('height', expandlpHeight+lpHeight+107+'px');
    });

    //user info open-close
    $j('.user_info').click(function(event) {
        event.stopPropagation();
        $j('.user_detail').toggleClass('show');
    });
    $j('.user_detail').click(function(event) {
        event.stopPropagation();
    });
    $j('.logout').focusout(function(event) {
        $j('.user_detail').removeClass('show');
    });

    //search focus in-out
    $j('.search input[type="text"]').focus(function(){
        $j('.search').css('background-position','0 -40px');
    });
    $j('.search input[type="text"]').blur(function(){
        $j('.search').css('background-position','0 0');
    });

    //lnb fold
    $j('.depth1').siblings('.depth2').parent().find('.depth1 span').addClass('fold');

	$j(document).on("click", '.depth1 .foldtop', function(event){
        event.stopPropagation();
        var isDepth2 = $j(this).parent().siblings('.depth2').length;
        var depth2 = $j(this).parent().siblings('.depth2');
        if(isDepth2) {
            depth2.toggleClass('show');
            $j(this).children('.icon.fold').toggleClass('open');
        }
    });

    /*$j('.mail_list li a').click(function(event) {
        $j('.listname').removeClass('strong');
        $j(this).find('.listname').addClass('strong');
    });*/

    $j('.count').click(function(event) {
        event.stopPropagation();
    });

    //주소록 리스트 열기/닫기
    if('.category li>ul') {
		$j('.category ul').parent().css('padding-left','12px');
	}

	$j('.category a + ul').siblings('a').find('span').addClass('spread');
	$j('.category a').click(function(event) {
		$j(this).siblings('ul').toggleClass('show');
		if($j(this).siblings('ul').length) {
			$j(this).find('span').toggleClass('collapse');
		}
	});

    //lnb drag - modern browser,IE10+ available
     $j( "#drag" ).draggable({ containment: "#drag_wrap", scroll: false, axis: "x" });
    // $j( "#drag" ).draggable({
    // drag: function(event) {
    //     var top = $j(this).position().top;
    //     var left = $j(this).position().left + 255;
    //     //console.log(left);
    //     $j('#leftmenu').css({'width':left});
    //     $j('#contents').css({'left':left});
    // }});

     $j( "#drag" ).draggable({
        drag: function(event) {
            var top = $j(this).position().top;
            var left = $j(this).position().left + 255;
            //console.log(left);
            $j('#leftmenu').css({'width':left});
            $j('#contents').css({'left':left});
        },
        stop: function( event, ui ) {
            setCookie( 'office_lnb_width', $j('#leftmenu').width() );
            //alert(document.cookie);
        }
    });


    //첨부파일 열기/닫기
    var isAddFilesOpen = true;
    $j('.addFiles > p > .icon').click(function(event) {
        if(isAddFilesOpen) {
            $j(this).css('background-position', '-258px -38px');
            $j('.filebox').hide();
            $j('.submit').hide();
        }else{
            $j(this).css('background-position', '-276px -38px');
            $j('.filebox').show();
            $j('.submit').show();
        }
        isAddFilesOpen = !isAddFilesOpen;
    });

    //대용량 첨부에 관한 메시지 - 쓰기페이지
    $j('.tipsIcon').bind('mouseenter focusin',function() {
        $j(this).siblings('.tooltip').addClass('show');
    });
    $j('.tipsIcon').bind('mouseleave focusout',function() {
        $j(this).siblings('.tooltip').removeClass('show');
    });

    //받는 사람 및 참조 textarea 높이 조절 - 쓰기페이지
    $j(".to_addr").keyup(function () {
        adaptiveHeight(this);
    });
    $j(".cc_addr").keyup(function () {
        adaptiveHeight(this);
    });
    function adaptiveHeight(txt_area) {
        $j(txt_area).innerHeight(0);
        var scrollval = $j(txt_area)[0].scrollHeight;
        $j(txt_area).innerHeight(scrollval);
        if (parseInt(txt_area.style.innerHeight) > $j(window).innerHeight()) {
            $j(document).scrollTop(parseInt(txt_area.style.innerHeight));
        }
    }

    //탭 메뉴
    $j('.tabType1 li a').bind('click', function(){
        var idx = $j(this).parent().index();
        $j('.tab_page').hide();
        $j('.tabType1 li').removeClass();
        $j('.tab_page').eq(idx).show();
        $j(this).parent().addClass('on');
    });

    //세금계산서 탭 메뉴
    $j('#tab_tax li a').bind('click', function(){
        var idx2 = $j(this).parent().index();
        $j('.tab_page').hide();
        $j('#tab_tax li').removeClass();
        $j('.tab_page').eq(idx2).show();
        $j(this).parent().addClass('active');
    });


    // 테이블 열고 닫기
    $j('.opentable').click(function(){
        $j(this).toggleClass('close');
        $j(this).parent().parent().parent().siblings('.bodyHide').toggleClass('show');
    });

    //list gradient
    var gWidth = $j('.content_inbox').width();

    $j(window).resize(function() {
        gWidth = $j('.content_inbox').width();
        g_list();
    });
    $j(window).load(function() {
        gWidth = $j('.content_inbox').width();
        g_list();
    });
    $j('.content_inbox').scroll(function() {
        g_list();
    });
    function g_list(){
        var gradient = $j(".gradient");
        var gPosition = $j('.content_inbox').scrollTop();
        if(gPosition > 50){
            gradient.fadeIn('fast');
            gradient.css('width', gWidth-16+'px');
        }else{
            gradient.fadeOut('fast');
        }
    }

    /* switch
    $j('.switch input[type=checkbox]').click(function(){
         if( $j(this).attr('checked')) {
            $j(this).parent().addClass('on');
            $j(this).attr('checked','checked');
            $j(this).attr('title','on');
         }else{
            $j(this).parent().removeClass('on');
            $j(this).removeAttr('checked');
            $j(this).attr('title','off');
         }

    });*/

    /* tooltip */
    $j('.tooltip-layer .ttip-link').click(function(){
        $j(this).siblings('.ttip_box').toggleClass('hide');
    });
    $j('.tooltip-layer .btn_closelayer').click(function(){
        $j(this).parent().addClass('hide');
    });

    /* aside tooltip */
    //$j('.aside .sch_list a').hover(function(){
      //  $j(this).siblings('.hover_box').toggleClass('hide');
    //});

    //var favLyheight = $j('#favLayer').height() / 2 * -1;
    var myMemu = $j('.home_list>li').length;
    var favMargin = (10 - myMemu) * 43;
    var compMenu = $j('.comp_fav>li').length;
    var compMargin =(5 - compMenu) * 43;

    $j('#showFavlayer').mouseenter(function(e){
        $j('#favLayer').addClass('show');
        $j('#favLayer').removeClass('hide');
        $j('#favLayer').css({'marginTop' : 0});
        $j('.fav_setting + ul').css({'max-height' : 350 + compMargin + 'px'});

    });

     $j('#favLayer').mouseleave(function(e){
        $j(this).addClass('hide');
        $j(this).removeClass('show');
    });


    /* show more */
    /* service extend */
    $j('#extendMore').click(function() {
        $j('.showMore').css({'display':''});
        $j(document).bottomFixScroll();
        $j('html, body').animate({ scrollTop: $j(window).scrollTop() - 1 }, 0);
    });

    /* mobile search area */
    $j('#searchBtn').click(function() {
        $j('#searchAfter').addClass('show');
        $j('#searchBefore').addClass('hide');
    });

    $j('#searchCancel').click(function() {
        $j('#searchAfter').removeClass('show');
        $j('#searchBefore').removeClass('hide');
    });

    /* mobile menu */
    $j('#showMobilemenu').click(function(){
        $j(this).toggleClass('expand');
        $j('#expandMobilemenu').toggleClass('hide');
    });

	//resize function
	var resizeTimeout = false;
	function resizeFunction(){
		var getTagheight = $j('#searchResult').outerHeight();
		if(getTagheight === null) getTagheight = 0;
		if($j('.content_inbox.mail_inbox').length > 0)
		{
			$j('.content_inbox.mail_inbox').css('top', getTagheight + 61);
		}
	};

	$j(window).on("resize", function(){
		clearTimeout(resizeTimeout);
		resizeTimeout = setTimeout(resizeFunction, 250);
	});

//td in div height


    $j('.cal_table1.approve-write tr').each(function (index) {
        var thHeight = $j(this).children('th').height();
		var thWidth = $j(this).children('th').width();
		$j(this).find('th > div').css({'height' : (thHeight - 1) + 'px'});
		$j(this).find('th > div').css({'display' : 'table-cell'});
		$j(this).find('th > div').css({'width' : (thWidth - 1) + 'px'});
		$j(this).find('th > div').css({'vertical-align' : 'middle'});
		$j(this).find('th > div').css({'text-align' : 'center'});

    });

    $j('.tableType01.reception tr').each(function (index) {
        var thHeight2 = $j(this).children('th').height();
        $j(this).find('th > div').css({'height' : (thHeight2 - 1) + 'px'});
        $j(this).find('th > div').css({'line-height' : (thHeight2 -1 ) + 'px'});
        $j(this).children('th').height();

    });

	var conferHeight = $j('.approval-wrap .cal_table1 .confer').height();
	$j('.approval-wrap .cal_table1 .confer table').css({'height' : conferHeight + 'px'});

	//console.log(conferHeight);

	/** 예약 솔루션 **/
	// 기본 설정 보이기
	$j('#resourceControll').click(function(event) {
		event.stopPropagation();
		$j('#defaultSet').toggleClass('show');
		if ($j('#defaultSet').hasClass('show')) {
			$j('#resourceControll .icon.down').addClass('deg180');
		} else {
			$j('#resourceControll .icon.down').removeClass('deg180');
		}
	});

	// 좌우 버튼 누르면 레이어 보이기
	$j(document).on('click', '.rs-cal-table .rs-btn.left', function () {
//	$j('.rs-cal-table .rs-btn.left').click(function() {
		if ($j('#page_list_ul').find('li.paging_before_li').length < 1) {
			return false;
		}

		$j('#showMoreResource').removeClass('hide');
		$j('#showMoreResource').addClass('left');

		$j('.paging_before_li').removeClass('hide');
		$j('.paging_after_li').addClass('hide');
	});

	$j(document).on('click', '.rs-cal-table .rs-btn.right', function () {
//	$j('.rs-cal-table .rs-btn.right').click(function() {
		if ($j('#page_list_ul').find('li.paging_after_li').length < 1) {
			return false;
		}

		$j('#showMoreResource').removeClass('hide');
		$j('#showMoreResource').removeClass('left');

		$j('.paging_before_li').addClass('hide');
		$j('.paging_after_li').removeClass('hide');
	});

	$j('.rs-view .dropdown-menu li').click(function() {
		$j('#showMoreResource').removeClass('show');
		$j('#showMoreResource').removeClass('left');
	});
	/** //예약 솔루션 **/
});


//popup show-hide
var popup_window;
var dimmed = $j('#dimmed');
var focusableElementsString = "a[href], area[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, *[tabindex], *[contenteditable]";
var focusedElementBeforeModal;
function showPopup(obj) {
    popup_window = obj;
    dimmed = $j('#dimmed');
    popup_window.css({'marginLeft': popup_window.outerWidth() / 2 * -1});
    popup_window.css({'marginTop': popup_window.outerHeight() / 2 * -1});
    dimmed.show();
    popup_window.show();
    focusedElementBeforeModal = $j(':focus');
    var o = popup_window.find('*');
    o.filter('p');
    o.filter(focusableElementsString).filter(':visible').first().focus();
}
function hidePopup() {
    dimmed.hide();
    popup_window.hide();
    focusedElementBeforeModal.focus();
}
