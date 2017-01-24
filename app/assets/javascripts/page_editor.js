PageEditor = function(displayMode, getLink, linkClicked) {
    self = this;
    self.displayMode = displayMode;
    this.simpleMDE = new SimpleMDE({
        autoDownloadFontAwesome: false,
        toolbar: [
            "bold", "italic", "strikethrough",
            "|", // Separator
            "heading-1", "heading-2", "heading-3",
            "|", // Separator
            "unordered-list", "ordered-list",
            "|", // Separator
            {
                name: "link",
                action: function customFunction(editor) {
                    console.log("link");
                    getLink(function(link) {
                      SimpleMDE.drawLink(editor, link);
                    })
                },
                className: "fa fa-link",
                title: "Add Link"
            },
            {
                name: "image",
                action: function customFunction(editor) {
                    console.log("image");
                    SimpleMDE.drawImage(editor);
                },
                className: "fa fa-image",
                title: "Add Image"
            },
            "|", // Separator
            {
                name: "togglePreview",
                action: function customFunction(editor) {
                    SimpleMDE.togglePreview(editor);
                    console.log("preview done")
                    self.configureLinks();
                },
                className: "fa fa-eye",
                title: "Toggle Preview (Cmd-P)"
            },
            /*
            {
                name: "toggleSideBySide",
                action: function customFunction(editor) {
                    console.log("side by side");
                    SimpleMDE.toggleSideBySide(editor);
                },
                className: "fa fa-columns",
                title: "Toggle Preview (Cmd-P)",
            },
            "fullscreen"
            */
        ]
    });

    this.configureLinks = function() {
        setTimeout(function() {
            console.log("looking for preview active");
            // if entering preview mode
            if ($(".editor-preview-active").length == 1) {
                console.log("entered preview mode")
                $(".editor-preview a").each(function (index, elem) {
                    var href = $(elem).attr('href');
                    console.log("a html = " + href);
                    $(elem).click(function(e) { console.log("href clicked = " + href); linkClicked(href); e.preventDefault(); });
                })
            }
        }, 100)
    }

    /*
    this.simpleMDE.codemirror.on('refresh', function() {
        if (this.simpleMDE.isFullscreenActive()) {
            $('body').addClass('simplemde-fullscreen');
        } else {
            $('body').removeClass('simplemde-fullscreen');
        }
    });
    */

    if (this.displayMode != 'edit') {
        this.simpleMDE.togglePreview();
        this.configureLinks();
    }
}
