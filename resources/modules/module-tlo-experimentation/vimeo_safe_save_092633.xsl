<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/html.xsl"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        
        
        
        <script src="http://a.vimeocdn.com/js/froogaloop2.min.js"></script>
        
        <script>
            /**
            * Called once a vimeo player is loaded and ready to receive
            * commands. You can add events and make api calls only after this
            * function has been called.
            *
            * @param String $player_id — id of the iframe element firing the event. This is
            * useful when listening to multiple videos so you can identify which one fired
            * the event.
            */
            function ready(player_id) {
            // Keep a reference to Froogaloop for this player
                var player = $f(player_id),
            
                playButton = document.getElementById('play-btn');
            
                /**
                * Attach event listeners.
                *
                * If you're using a javascript framework like jQuery or Mootools
                * you'll probably use their addEvent method to add the click events.
                * Here we're just using the standard W3C addEventListener method. If
                * you need IE8 support, you'll need to use attachEvent for IE8 and
                * addEventListener for everything else (or just use jQuery or MooTools).
                */
                
                playButton.addEventListener('click', function() {
                    player.api('play');
                });
                
                }
                
                window.addEventListener('load', function() {
                    //Attach the ready event to the iframe
                    $f(document.getElementById('vimeo-player')).addEvent('ready', ready);
                });
            
        </script>
        
        
        <iframe id="vimeo-player" src="http://player.vimeo.com/video/58611436?api=1&amp;player_id=vimeo-player&amp;title=0&amp;byline=0&amp;portrait=0" width="500" height="281" frameborder="0"></iframe>
        
        <button id="play-btn" name="play" />
        
        
        
    </xsl:template>
    
   
    
</xsl:stylesheet>