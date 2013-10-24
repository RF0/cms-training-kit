var STK = STK || {
};


// Prevent Internet Explorer from halting scripts when encountering console.log()
if (typeof console == 'undefined') {
	console = {
		log: function () {}
	};
}


$(function() {
    STK.responsive.optimizeImages();    
    STK.responsive.optimizeIframes($('.youtube.video'));   
    STK.navigation.toggleMenu($('header nav'), $('header .menu-trigger'), {});
    
    STK.pagination.clickLoad($('.article-list > ol'), $('.article-list > nav.pagination'));
    
    

});