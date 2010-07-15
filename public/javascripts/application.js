var playing = false;
var done = false
var timer = 0;
var flags = 10;
var tiles = 64;
$(document).ready(function() {
    // while(e_name == ''){
    //      e_name = prompt("Please enter your name");
    //     }
    //     $.post('/start', {name: e_name }, function(data){
    //                 g_id = data.id;
    //                 $('#hello').html("Hi, " + data.name);
    //         }, "json");
	$('.tile').click(function(e){
		$tile = $(this);
		tile_id = $tile.attr('id').split('_')[1];
		parent_id = $tile.parent().attr('id').split('_')[1];
		if(playing == false){
			playing == true
			window.setTimeout('changeTime()', 1000);
		}
		if(e.shiftKey && !$tile.hasClass('checked')) { 
		    if(flags==0)
			return
			$.get('/games/'+g_id+'/tiles',{
				'tile[x]': tile_id,
				'tile[y]':parent_id,
				'flag': true
			});
			if($tile.hasClass('flagged')){
				$tile.removeClass('flagged')
				$tile.html('');
				flags++;
				$('#flags').html(flags);
			}else{
				$tile.addClass('flagged')
				$tile.html('|>');
				flags--;
				$('#flags').html(flags);
			}
		  } else if(!done){
			if(!$tile.hasClass('checked')){
				$.get('/games/'+g_id+'/tiles/',{
					'tile[x]': tile_id,
					'tile[y]': parent_id
				},function(data){
					handleStatus(data);
					$tile.addClass('checked');
				});
			}
		}
	});
	$('#flags').html(flags);
});

function changeTime () {
	if(!done){
		timer++;
		$('#time').html(timer);
	}
}

function handleStatus (data) {
	if(data['status'] == 0){
		for (var i=0;i<=data['mines'].length-1;i++) {
			$tile = $('#row_'+data['mines'][i]['y']+' > #tile_'+data['mines'][i]['x']);
			$tile.css('background-color','white');
			$tile.html('0');
		}
		done = true;
		$.post('/games/'+g_id,{
			'authenticity_token':AUTH_TOKEN,
			'_method': 'put',
			'game[status]': 'lost'
		});
		alert('You died');
	}else if(data['status'] == 1){
		return
	}else if(data['status'] == 2){
		for (var i=0;i<=data['tiles'].length-1;i++) {
			$tile = $('#row_'+data['tiles'][i]['y']+' > #tile_'+data['tiles'][i]['x']);
			$tile.css('background-color','white');
			if(data['tiles'][i]['count'] != 0){
				$tile.html(data['tiles'][i]['count']);
			}
		}
		tiles -= data['tiles'].length;
		if(tiles == 0){
			$.post('/games/'+g_id,{
				'authenticity_token':AUTH_TOKEN,
				'_method': 'put',
				'game[status]': 'won',
				'game[time]':timer
			});
		}
	}else {
		alert('Error');
	}
}