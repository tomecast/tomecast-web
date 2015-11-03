;(function($,window){

    $(function(){
      loop_audio_init()
    })


    function loop_audio_init() {
      if ($.exists('.jp-jplayer')) {
        $('.jp-jplayer.mk-blog-audio').each(function () {
          var css_selector_ancestor = "#" + $(this).siblings('.jp-audio').attr('id');
          var ogg_file, mp3_file, mk_theme_js_path;
          ogg_file = $(this).attr('data-ogg');
          mp3_file = $(this).attr('data-mp3');
          $(this).jPlayer({
            ready: function () {
              $(this).jPlayer("setMedia", {
                mp3: mp3_file,
                ogg: ogg_file
              });
            },
            play: function () { // To avoid both jPlayers playing together.
              $(this).jPlayer("pauseOthers");
            },
            swfPath: mk_theme_js_path,
            supplied: "mp3, ogg",
            cssSelectorAncestor: css_selector_ancestor,
            wmode: "window"
          });
        });
      }
    }

})(jQuery, window);