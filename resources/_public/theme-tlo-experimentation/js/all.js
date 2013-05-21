//@codekit-prepend "../../library-stk/js/jquery.js";
//@codekit-prepend "../../library-stk/js/modernizr.js";
//@codekit-prepend "../../library-stk/js/stk.js";
//@codekit-prepend "../../library-stk/js/stk-aria.js";

var STK = STK || {
};


$(function() {

   
    STK.responsive.optimizeImages();
    
    STK.navigation.toggleMenu($('header nav'), $('header .menu-trigger'), {});
   
    
    $('html').click(function () {
        if ($('header .menu-trigger').is(':visible')) {
            $('header nav').slideUp(100);
        }
    });
        
        
    $('header nav li').click(function(e) {
        if ($('header .menu-trigger').is(':visible')) {
            e.stopPropagation();
            if ($(this).children('ol').length > 0) {
                $(this).toggleClass('expanded');
                //$(this).children('ol').toggle();
                $(this).siblings().toggle();
            }
        }
    });
    
    window.onresize = function() {
        resetMenu();
    }
    
    
    function resetMenu() {
        if ($('header .menu-trigger').is(':hidden')) {        
            $('header nav').show();
        }
        $('header nav').find('.expanded').removeClass('expanded');
        
        $('header nav .menu-level-1 > li').show();
        //$('header nav .menu-level-2').css('display', 'none');
    }
    
    

});







STK.responsive = {
    optimizeImages: function () {
        $('img[data-srcset]').each(function() {
            var img = $(this);
            var srcset = img.data('srcset');     
            console.log(srcset);
            if (typeof srcset === 'object') {
                var sizes = [];
                for (var k in srcset) {
                    sizes.push(parseInt(k));
                }        
                sizes.sort(function(a,b) {return a-b});
                console.log(sizes);
                var width = Math.floor(img.width() * (window.devicePixelRatio || 1));    
                var srcIndex = getClosestHigherNum(width, sizes);
                img.attr('src', srcset[srcIndex]);
            }
        });
    }
};

// Get's the closest higher number in array 
function getClosestHigherNum(num, ar) {
    var closest = ar[0];
    for (var i = ar.length; i > 0; i--) {
        if (ar[i] > num) {
            closest = ar[i];
        }
    }
    return closest;
}