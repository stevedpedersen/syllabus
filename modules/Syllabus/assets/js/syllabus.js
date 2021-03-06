(function ($) {
  $(function () {

	$("div[id^=statistics]").on('shown.bs.collapse', function() {
		$("#collapseIcon").addClass('fa-minus-square').removeClass('fa-plus-square');
	});

	$("div[id^=statistics]").on('hidden.bs.collapse', function() {
		$("#collapseIcon").addClass('fa-plus-square').removeClass('fa-minus-square');
	});

  	// auto-scroll down to section being edited
	if ($('#editUri').length) {
		var uri = $('#editUri').val();
		var target = $(`div${uri}`);
		// document.location.href=`${document.location.href}${uri}`;
		// $('html,body').animate({scrollTop: target.offset().top}, 100);	
		window.scroll( {top: target.offset().top, behavior: 'smooth'} );
	}

    if ($('#syllabusEditor').length) {
        if ($('#sidebar').hasClass('active')) {
            // $('#sidebar').removeClass('active');
        } else {
            $('#sidebar').addClass('active');
        }
    }

	$('[id^=clickToCopy]').on("focus", function(e) {
		e.target.select();
	  $(e.target).one('mouseup', function(e) {
	    e.preventDefault();
	  });
	});
	
	$('[id^=copyBtn]').on('click', function (e) {
		if (window.navigator.userAgent.indexOf("Edge") > -1) {
			$('body').css({"position": "fixed" });	
		}
	
		e.preventDefault();
		e.stopPropagation();
		$(this).animate({"background-color":"#009B84", "color": "#009B84"}, 10)
			.animate({"background-color":"#ffffff"}, 1000, function () {
				if (window.navigator.userAgent.indexOf("Edge") > -1) {
					$('body').css({"position": "unset"});	
				}
			})
			.animate({"color": "#000000"}, 2000);
		
		const em = $(this).parents().siblings('[id^=clickToCopy]');
        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val(em.val()).select();
        document.execCommand("copy");
        $temp.remove();
        $(this).parents().siblings('[id^=copiedAlert]').animate({opacity:1}, 10).animate({opacity:0}, 1000);
	});

	$('#shareToggler').bootstrapToggle();

	 $('[data-toggle="popover"]').popover();

	// enable tooltips
	$('[data-toggle="tooltip"]').tooltip();

	$('.section-collapsible').on('hide.bs.collapse', function () {
		var icon = $(this).parent().find('.section-collapse-link').find('small > i');
		icon.removeClass('fa-chevron-down').addClass('fa-chevron-right');
	});
	$('.section-collapsible').on('show.bs.collapse', function () {
		var icon = $(this).parent().find('.section-collapse-link').find('small > i');
		icon.addClass('fa-chevron-down').removeClass('fa-chevron-right');
	});

	$('.anchor-links-sidebar .nav-link').on('click', function (e) {
		$('.anchor-links-sidebar').find('.nav-item > .active').removeClass('active');
		$(this).addClass('active');
	});


	$('.collapse-all').on('click', function (e) {
		e.preventDefault();
		if ($(this).hasClass('collapsed')) {
			$(this).removeClass('collapsed').addClass('expanded');
		} else {
			$(this).removeClass('expanded').addClass('collapsed');
		}
		$('.section-collapse-link').click();
		// $('.multi-collapse').toggle({
		// 	duration: 300
		// });
	});

	$('#anchorLinksCollapse .nav-link').on('click', function (e) {
		if ($(window).width() < 992) {
			e.preventDefault();
			var id = $(this).attr('href');
			id = id.substring(id.indexOf('#'));
			var target = $(id);
			var scrollTo = target.offset().top - 360;
			$('html,body').animate({
	          scrollTop: scrollTo
	        }, 500);
		}
	});

	var filterResources = function (option, showAll) {
		if (option.value !== '') {
			$('#removeFilterResources').show();
		} else {
			$('#removeFilterResources').hide();
		}
		$('.campus-resources .resource').each(function(index, item) {
			if (!showAll && option.value !== '' && !$(item).hasClass(option.value)) {
				$(item).hide(750);
			} else {
				$(item).show(500);
			}
		});
	}

	$('#filterResources').on('change', function(e) {
		filterResources(e.target, false);
		window.history.replaceState({}, null, (e.target.value ? '?category=' + e.target.value : ''));
	});

	$('#removeFilterResources').on('click', function(e) {
		filterResources(e.target, true);
		$('#filterResources').val('');
		window.history.replaceState({}, null, '');
	});

	// $('#submitFilter').on('click', function(e) {
	// 	filterResources($('#filterResources'), false);
	// });
	// $('#submitFilter').on('keypress', function(e) {
	// 	filterResources($('#filterResources'), false);
	// });

	if ($('#filterResources').length && $('#filterResources').val() !== "") {
		filterResources($('#filterResources')[0], false);
	}

	$('#resourcePreviewModal').on('show.bs.modal', function(e) {
		let cardBody = $(e.relatedTarget).parents('.card-body');
		let id = cardBody.attr('id');
		let title = cardBody.find('#title'+id);
		let img = cardBody.find('#image'+id);
		let url = cardBody.find('#url'+id);
		let hiddenText = cardBody.find('#hiddenText'+id);
		let text = hiddenText.length ? hiddenText : cardBody.find('#text'+id);
		let tags = cardBody.find('#tags'+id);
		$('#resourceTitle').html(title.html());
		$('#resourceImage').attr('src', img.attr('src'));
		$('#resourceDescription').html(text.html());
		$('#resourceUrl').attr('href', url.text()).text('Visit ' + title.text());
		$('#resourceTags').html(tags.html());
	});
	$('#resourceAddModal').on('show.bs.modal', function(e) {
		let cardBody = $(e.relatedTarget).parents('.card-body');
		let id = cardBody.attr('id');
		let title = cardBody.find('#title'+id);
		let img = cardBody.find('#image'+id);
		let resourceId = cardBody.find('#campusResourceId'+id).val();
		$('#addTitle').html(title.html());
		$('#addImage').attr('src', img.attr('src')).attr('alt', img.attr('alt'));
		$('#resourceToSyllabiBtn').attr('name','command[resourceToSyllabi]['+resourceId+']');

		if ($('#resourcesSection')) {
			$('.campus-resource-input').each(function(i, em) {
				let linkedCampusResource = $('#linkedCampusResource' + $(em).attr('data-id'));
				// console.log(linkedCampusResource, $(em).attr('data-id'));
				if (linkedCampusResource && linkedCampusResource.val() == $(em).attr('data-id')) {
					let input = $(em).find('input');
					$(input).attr('checked', true);
					$('#checkIcon' + $(em).attr('id')).show();
					$(input).attr('readonly', true);
					$(input).attr('disabled', true);
					$(em).addClass('bg-light');
				}	
			});	
		}
	});
	$('#resourceAddModal').on('hide.bs.modal', function(e) {
		$(this).find('[id^=overlayCheck]:checked').each(function(i, em) {
			$(em).click();
		});
		$('.resource-category input').attr('checked', false).prop('checked', false);
	});
    $('[id^=overlayCheck]').on('change', function (e) {
		var id = $(this).attr('data-index');
		if (this.checked == true) {
			$('#checkIcon'+id).show();
		} else {
			$('#checkIcon'+id).hide();
			$(this).parents('.resource-card').removeClass('border-warning');
		}
    });
    var templateId = $('#templateId input[name="template"]');
    if (templateId.length)
    {
    	if (templateId.val() == 1)
    	{
    		var id = templateId.attr('data-index');
    		if ($('[id^=overlayCheck]').checked == true) {
    			$('#checkIcon'+id).show();	
    		}
    	}
    }

    if ($('#toggleSummaryModal').length) {
    	$('#toggleSummaryModal').click();
    }
	$('#resourceAddSummaryModal').on('hidden.bs.modal', function (e) {
		window.location.replace(window.location.href);
	});


	// select campus resources in the editor modal by category
	var selectedList = new Array;

	$('.resource-category input').on('change', function (e) {
		var tagId = $(this).val();
		var checked = this.checked;
		var total = 0;

		$('.campus-resource-input').each(function(i, em) {
			let linkedCampusResource = $('#linkedCampusResource' + $(em).attr('data-id'));
			let tagIdList = $(em).attr('data-tags-ids').split(' ');
			let input = $(em).find('input');

			if (checked && tagIdList.includes(tagId)) {
				if ($(input).prop('disabled') !== true) {
					$(input).attr('checked', true);
					$(input).prop('checked', true);
					$(em).parent().addClass('border-warning');
					$('#checkIcon' + $(em).attr('id')).show();
					total += 1;
				}
			} else if (!checked && tagIdList.includes(tagId)) {
				if ($(input).prop('disabled') !== true) {
					$(input).attr('checked', false);
					$(input).prop('checked', false);
					$(em).parent().removeClass('border-warning');
					$('#checkIcon' + $(em).attr('id')).hide();
					total += 1;
				}
			}
		});	

		if (checked && !selectedList.includes(tagId)) {
			selectedList.push(tagId);
		} else if (!checked) {
			const index = selectedList.indexOf(tagId);
			if (index > -1) {
				selectedList.splice(index, 1);
			}
		}

		if (total > 0) {
			let pluralOrSingular = total === 1 ? 'resource' : 'resources';
			if (checked) {
				$('#categoryAddMessage').text(`${total} ${pluralOrSingular} selected`).show();
			} else {
				$('#categoryAddMessage').text(`${total} ${pluralOrSingular} unselected`).show();
			}				
		} else {
			if (checked) {
				$('#categoryAddMessage').text('No new resources were selected with this category.').show();
			} else {
				$('#categoryAddMessage').text('No new resources were unselected with this category.').show();
			}
		}
		setTimeout(() => { $('#categoryAddMessage').hide("slow") }, 2000);
	});
	// end select resources by category


    var $sidebar   = $(".anchor-links-sidebar > .sidebar-sticky > ul");
    var maxW = 767;
    if (!$sidebar.length) {
    	$sidebar = $(".anchor-links-sidebar-left > .sidebar-sticky > ul");
    	maxW = 991;
    }
    var $window    = $(window),
        minimize   = false,
		scrollPos = 0,
    	windowWidth = $(window).width();

    $window.resize(function() {
        windowWidth = $(window).width();

	    if (windowWidth < 992) {
	    	$('#stickyNavbar').addClass('sticky');
			var scrollPos = 0;
			$window.scroll(function () {
			    var currentScrollPos = $(this).scrollTop();
			    stickyMobileLinks(scrollPos, currentScrollPos);
			    scrollPos = currentScrollPos;
			});   	
	    }
    });

    if (windowWidth < 992) {
		$('#stickyNavbar').addClass('sticky');
		var scrollPos = 0;
		$window.scroll(function () {
		    var currentScrollPos = $(this).scrollTop();
		    stickyMobileLinks(scrollPos, currentScrollPos);
		    scrollPos = currentScrollPos;
		});  	
    }

	var stickyMobileLinks = function (scrollPos, currentScrollPos) {
		var $stickyNavbar = $('#stickyNavbar');
	    if ((scrollPos > 375) && (currentScrollPos > scrollPos)) {
	    	if (!$stickyNavbar.hasClass('minimize')) {
	    		$stickyNavbar.addClass('minimize');
	    	}
	    } else {
	    	if ($stickyNavbar.hasClass('minimize')) {
	    		$stickyNavbar.removeClass('minimize');
	    	}
	    } 		
	}

    $('#anchorLinksCollapse a').on('click', function (e) {
    	$('#stickyNavbar .navbar-toggler').click();
    	if (!$('#stickyNavbar').hasClass('minimize')) {
    		$('#stickyNavbar').addClass('minimize');
    	}
    });


    if ($('#mySyllabi').length) {
    	var $modeEm = $('#mySyllabi').find('input[name="mode"]');
    	// var mode = $modeEm.val();
    	var selector = '#myTab a#' + $modeEm.val() +'-tab';
    	$(selector).tab('show');
    }


	$("#makeReadOnly").on("click", function(){
		if($(this).is(":not(:checked)")) {
			$('#readOnlyHelpBlock').show();
		}
		else {
			$('#readOnlyHelpBlock').hide();
		}
	});


	$('#ilearnChooseStartingPoint input').on('click', function() {
		// console.log('upload clicked', $('#upload').is(':checked'));
	    if( $('#upload').is(':checked')) {
	        $("#ilearnUploadSyllabus").show(500);
	    } else if (!$('#upload').is(':checked')) {
	        $("#ilearnUploadSyllabus").hide(500);
	    }
	    if ($('#base').is(':checked')) {
	    	$('#ilearnStartBase').show(500);
	    } else if (!$('#base').is(':checked')) {
	    	$('#ilearnStartBase').hide(500);
	    }
	    if ($('#existing').is(':checked')) {
	    	$('#ilearnStartExisting').show(500);
	    } else if (!$('#existing').is(':checked')) {
	    	$('#ilearnStartExisting').hide(500);
	    }
	});

    if( $('#ilearnChooseStartingPoint #upload').is(':checked')) {
        $("#ilearnUploadSyllabus").show();
    }
    if( $('#ilearnChooseStartingPoint #base').is(':checked')) {
        $("#ilearnStartBase").show();
    }
    if( $('#ilearnChooseStartingPoint #existing').is(':checked')) {
        $("#ilearnStartExisting").show();
    }

	// // accessibility fix for smooth scrolling links
	// // Select all links with hashes
	// $('a[href*="#"]')
	//   // Remove links that don't actually link to anything
	//   .not('[href="#"]')
	//   .not('[href="#0"]')
	//   .click(function(event) {
	//     // On-page links
	//     if (
	//       location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
	//       && 
	//       location.hostname == this.hostname
	//     ) {
	//       // Figure out element to scroll to
	//       var target = $(this.hash);
	//       target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
	//       // Does a scroll target exist?
	//       if (target.length) {
	//         // Only prevent default if animation is actually gonna happen
	//         event.preventDefault();
	//         $('html, body').animate({
	//           scrollTop: target.offset().top
	//         }, 200, function() {
	//           // Callback after animation
	//           // Must change focus!
	//           var $target = $(target);
	//           $target.focus();
	//           if ($target.is(":focus")) { // Checking if the target was focused
	//             return false;
	//           } else {
	//             $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
	//             $target.focus(); // Set focus again
	//           };
	//         });
	//       }
	//     }
	//   }); 


  });
})(jQuery);


