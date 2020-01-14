
function getImagesHeight(screenWidth){
    print("3333333333333");
    var imagesHeight = 0;
    for(i=0;i <document.images.length;i++){
        var image = document.images[i];
        var imgW = image.width;
        var imgH = image.height;
        var realImgH = screenWidth*imgH/imgW;imagesHeight += realImgH;
    } 
    // window.webkit.messageHandlers.getWebHeight.postMessage(imagesHeight)

    window.flutter_inappbrowser.callHandler('getWebHeight',imagesHeight);

    
}