Event.observe(window, "load", function() {
  // Disable Stream#mount_point in /streams/_form for shoutcast servers
  var toggle_stream_mount_point = function(enable) {
    $$('input[name="stream[mount_point]"]').each(function(input) {
      if (enable) {
        input.enable();
      } else {
        input.disable();
      };
    });
  };

  $$('select[name="stream[server_type]"]').each(function(select) {
    toggle_stream_mount_point(select.value != "shoutcast");
    Event.observe(select, 'change', function() {
      toggle_stream_mount_point(select.value != "shoutcast");
    });
  });

  // Disable Stream#mount_point in /streams/_form for shoutcast servers
  var toggle_stream_bitrate_quality = function(attribute, enable) {
    $$('[name="stream[' + attribute + ']"]').each(function(input) {
      if (enable) {
        console.log("show " + attribute);
        input.up().show();
      } else {
        console.log("hide " + attribute);
        input.up().hide();
      };
    });
  };

  var toggle_stream_mode = function(attribute, enable) {
    $$('[id="stream_mode_' + attribute + '"]').each(function(input) {
      if (enable) {
        console.log("show " + attribute);
        input.up().show();
      } else {
        console.log("hide " + attribute);
        input.up().hide();
      };
    });
  };

  $$('input[name="stream[mode]"]').each(function(radio) {
    var allows_cbr = radio.getAttribute("data-allows-cbr") == "true";
    var allows_vbr = radio.getAttribute("data-allows-vbr") == "true";

    if (radio.checked) {
      toggle_stream_bitrate_quality("bitrate", allows_cbr);
      toggle_stream_bitrate_quality("quality", allows_vbr);
    }
                                        
    Event.observe(radio, 'change', function() {
      toggle_stream_bitrate_quality("bitrate", allows_cbr);
      toggle_stream_bitrate_quality("quality", allows_vbr);
    });
  });

  $$('input[name="stream[format]"]').each(function(radio) {
    var allows_cbr = radio.getAttribute("data-allows-cbr") == "true";
    var allows_vbr = radio.getAttribute("data-allows-vbr") == "true";

    if (radio.checked) {
      toggle_stream_mode("cbr", allows_cbr);
      toggle_stream_mode("vbr", allows_vbr);
    }
                                        
    Event.observe(radio, 'change', function(e) {
      toggle_stream_mode("cbr", allows_cbr);
      toggle_stream_mode("vbr", allows_vbr);
      replace_bitrate_select(e.element().value);
    });
  });
});
