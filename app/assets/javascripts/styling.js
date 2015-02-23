/**
 * Created by erikmagnusson on 29/01/15.
 *//*

/*window.onload = function(){
    var appended = false;
    $( "#target" ).click(function() {
        if(appended == false){
            $( "#target" ).html("You had an account all along? Well sign in then!").fadeOut();
            $( "#email-box" ).delay(600).css( "display", "").fadeIn();


            $( "#login-button" ).fadeOut(600, function(){
                $( "#target" ).html("You had an account all along? Well sign in then!").fadeIn();
                $( "#login-button" ).css( "display", "none").fadeOut();
                $( ".checkbox" ).css( "display", "none").fadeOut();
                $( "#create-button" ).css( "display", "").fadeIn();
            });
            appended = true;
        }else {
            $( "#target" ).html("Don't have an account? Create one!").fadeOut();
            $( "#email-box" ).fadeOut(600, function(){
                $( "#email-box" ).css( "display", "none").fadeOut();//empty().append('<div class="checkbox"><label><input type="checkbox"> Remember me</label></div>').fadeIn()
            });
            $( "#create-button" ).fadeOut(600, function(){
                $( ".checkbox" ).css( "display", "").fadeIn();
                $( "#target" ).html("Don't have an account? Create one!").fadeIn();
                $( "#login-button" ).css( "display", "").fadeIn();
                $( "#create-button" ).css( "display", "none").fadeOut();
            });

            appended = false;
        }
    });
}*/
