
App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
 
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
 
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data['message']);
    var conversation = $('#conversations-list').find("data-conversation-id='" + data['conversation_id'] + "']");

    conversation.find('.messages-list').find('ul').append(data['message']);

    var message_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height); 
  },
 
  speak: function() {
    return this.perform('speak',{
      message: this.message
    });
  }
});

$(document).on('submit','.new_message',function(e){
  e.preventDefault();
  var values= $(this).find('textarea').val()
  App.conversation.speak(values);
  $(this).trigger('reset');
});