console.log('initialize');

var foundElements = [];

//create the observer
var observerConfig = {attributes: false, childList: true, characterData: false, subtree:true};
var observer = new MutationObserver(function(mutations) {
    //check for elements you want to observe
    //console.log('observer trigger', mutations);

    //check for spinner element
    if (document.body.contains(document.querySelector('[class*="spinner_"]'))) {
    	if (!foundElements.includes('spinner_')) {
        	console.log("spinnerElement added to DOM");
        	foundElements.push('spinner_');
        	//do something
    	}
    }
    
    //check for description element
    if (document.body.contains(document.querySelector('[class*="description_"]'))) {
        if (!foundElements.includes('description_')) {
        	console.log("descriptionElement added to DOM");
        	foundElements.push('description_');
        	//do something
    	}
    }
    
    //check for chart chart data 
    if (document.body.contains(document.querySelector('[class*="captionWithChart_"] .highcharts-series-group .highcharts-series'))) {
        if (!foundElements.includes('[class*="captionWithChart_"] .highcharts-series-group .highcharts-series')) {
        	console.log("chartData added to DOM");
        	foundElements.push('[class*="captionWithChart_"] .highcharts-series-group .highcharts-series');
        	//do something
    	}
    }
    
    //check for word cloud
    if (document.body.contains(document.querySelector('[class*="asoModule_"] .highcharts-series-group .highcharts-series'))) {
        if (!foundElements.includes('[class*="asoModule_"] .highcharts-series-group .highcharts-series')) {
        	console.log("word cloud added to DOM");
        	foundElements.push('[class*="asoModule_"] .highcharts-series-group .highcharts-series');
        	//do something
    	}
    }
    
    //TODO
    //Copy the above code blocks for any further elements we need to observe
});

//initialize observers
observer.observe(document, observerConfig);
