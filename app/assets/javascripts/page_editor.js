PageEditor = function(getLink) {
    this.simpleMDE = new SimpleMDE({
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
            "preview", "side-by-side", "fullscreen"
        ]
    });
    this.simpleMDE.togglePreview();
}
