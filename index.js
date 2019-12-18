var Matomo = require('react-native').NativeModules.Matomo;
module.exports = {
  initTracker: function(url, siteId, dimension) {
    Matomo.initTracker(url, siteId, dimension)
  },
  setUserId: function(userId) {
    if (userId !== null && userId !== userId !== undefined) {
      Matomo.setUserId(userId + '');
    }
  },
  setCustomDimension: function(id, value){
    Matomo.setCustomDimension(id, value ? (value + '') : null);
  },
  trackAppDownload: Matomo.trackAppDownload,
  trackScreen: function(path, title) {
    Matomo.trackScreen(path, title);
  },
  trackGoal: function(goalId, revenue) {
    Matomo.trackGoal(goalId, {revenue});
  },
  trackEvent: function(category, action, name, value, url) {
    Matomo.trackEvent(category, action, {name, value, url});
  },
  trackCampaign: function(name, keyword) {
    Matomo.trackCampaign(name, keyword);
  },
  trackContentImpression: function(name, piece, target) {
    Matomo.trackContentImpression(name, {piece, target});
  },
  trackContentInteraction: function(name, interaction, piece, target) {
    Matomo.trackContentInteraction(name, {interaction, piece, target});
  },
  trackSearch: function(query, category, resultCount, url) {
    Matomo.trackSearch(query, {category, resultCount, url});
  },
  setAppOptOut: function(optOut) {
    Matomo.setAppOptOut(optOut);
  }
};
