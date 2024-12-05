//This code is an extension of our typical Analytics - Segment - Library / Pageview GTM tag
//Major differences here:
//- Creates a session cookie
//- Pushes a session_started event to dataLayer
//- Creates an event listener that will "keep alive" the cookie expiration if user takes any action (mousemove, touch, click, etc)


//Segment code snippet
//Always replace this with the latest version (copy paste from Segment Analytics.js source)
  !function(){var i="analytics",analytics=window[i]=window[i]||[];if(!analytics.initialize)if(analytics.invoked)window.console&&console.error&&console.error("Segment snippet included twice.");else{analytics.invoked=!0;analytics.methods=["trackSubmit","trackClick","trackLink","trackForm","pageview","identify","reset","group","track","ready","alias","debug","page","screen","once","off","on","addSourceMiddleware","addIntegrationMiddleware","setAnonymousId","addDestinationMiddleware","register"];analytics.factory=function(e){return function(){if(window[i].initialized)return window[i][e].apply(window[i],arguments);var n=Array.prototype.slice.call(arguments);if(["track","screen","alias","group","page","identify"].indexOf(e)>-1){var c=document.querySelector("link[rel='canonical']");n.push({__t:"bpc",c:c&&c.getAttribute("href")||void 0,p:location.pathname,u:location.href,s:location.search,t:document.title,r:document.referrer})}n.unshift(e);analytics.push(n);return analytics}};for(var n=0;n<analytics.methods.length;n++){var key=analytics.methods[n];analytics[key]=analytics.factory(key)}analytics.load=function(key,n){var t=document.createElement("script");t.type="text/javascript";t.async=!0;t.setAttribute("data-global-segment-analytics-key",i);t.src="https://cdn.segment.com/analytics.js/v1/" + key + "/analytics.min.js";var r=document.getElementsByTagName("script")[0];r.parentNode.insertBefore(t,r);analytics._loadOptions=n};analytics._writeKey="V18idRLshuWOwAOe9OFMeb0waoKWVI6A";;analytics.SNIPPET_VERSION="5.2.0";
  
  //load write key
  analytics.load("{{Analytics - Lookup - Segment Staging / Live}}");
  
  //if a session cookie is not present, reset it
  if (document.cookie.split('; ').filter(function(row) {
    return row.indexOf('analytics_session_id=') === 0; 
  }).length === 0) {
    var date = new Date();
    date.setTime(date.getTime() + (30 * 60 * 1000));
    
    document.cookie = "analytics_session_id=" + Date.now() + ";expires=" + date.toUTCString() + ";path=/";
    
    //we are setting a new session cookie, so this will begin a new session
    window.dataLayer.push({
        event: "session_started"  
    });
    
  }
  
  //instantiate the session observer
  observeSession();
    
  analytics.page();  
  
  }}();  //end Segment initialization
  
  function observeSession() {
    
    var userActivityEvents = ['click','keypress','mousemove','scroll','touchstart'];
  
    userActivityEvents.forEach(function(event) {
    
    document.addEventListener(event, function(e) {     
    
    //if a session cookie is not present, reset it
    if (document.cookie.split('; ').filter(function(row) {
      return row.indexOf('analytics_session_id=') === 0; 
    }).length === 0) {
      var date = new Date();
      date.setTime(date.getTime() + (30 * 60 * 1000));
      
      document.cookie = "analytics_session_id=" + Date.now() + ";expires=" + date.toUTCString() + ";path=/";
      
      //we are setting a new session cookie, so this will begin a new session
      window.dataLayer.push({
          event: "session_started"  
      });
      
    } else {
      //if session cookie is present, keep the value and update the expiry to 30 minutes 
      var cookieValue = document.cookie.split('; ').filter(function(row) {
          return row.indexOf('analytics_session_id=') === 0;
      })[0].split('=')[1];
      
      var date = new Date();
      date.setTime(date.getTime() + (30 * 60 * 1000));
      
      document.cookie = "analytics_session_id=" + cookieValue + ";expires=" + date.toUTCString() + ";path=/";
    }
      
    }); //end addEventListener 
    
  }); //end userActivityEvents forEach
    
  } //end observeSession
  
