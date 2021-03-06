(function ($) {
  $(function () {

    $('.btn-email-reminder').on('click', function (e) {
        if (!confirm('Are you sure you want to email all faculty with incomplete submissions?')) {
            e.preventDefault();
            e.stopPropagation();
        }
    });

    $('#reviewSubmissionModal').on('show.bs.modal', function(e) {
        var submissionId = $(e.relatedTarget).attr('data-submission');
        var status = $(e.relatedTarget).parents().siblings('.status').val();
        var feedback = $(e.relatedTarget).parents().siblings('.feedback').val();
        var dueDate = $(e.relatedTarget).parents().siblings('.dueDate').val();
        var submittedDate = $(e.relatedTarget).parents().siblings('.submittedDate').val();
        var approvedDate = $(e.relatedTarget).parents().siblings('.approvedDate').val();
        var courseSummary = $(e.relatedTarget).parents().siblings('.courseSummary').val();
        var syllabusId = $(e.relatedTarget).parents().siblings('.syllabusId').val();
        var syllabusTitle = $(e.relatedTarget).parents().siblings('.syllabusTitle').val();
        var fileSrc = $(e.relatedTarget).parents().siblings('.fileSrc').val();
        var fileName = $(e.relatedTarget).parents().siblings('.fileName').val();
        var action = $('#reviewSubmissionModal #editSubmissionForm').attr('action');

        $('#reviewSubmissionModal #editSubmissionForm').attr('action', action + submissionId);
        $('#submissionTitle').text('Evaluating submission for ' + courseSummary);
        $('#subCourseSection').text(courseSummary);
        $('#subDueDate').text(dueDate);
        $('#subSubmittedDate').text((submittedDate ? submittedDate : 'N/A'));
        $('#subApprovedDate').text((approvedDate ? approvedDate : 'N/A'));
        
        if (syllabusId) {
            $('#syllabusViewLink').attr('href', 'syllabus/' + syllabusId + '/view').text(syllabusTitle);
            $('#syllabusWordLink').attr('href', 'syllabus/' + syllabusId + '/word').text('Download as Word');
            if (!fileSrc) {
                $('#subFileDownload').text('N/A');
            } else {
                var message = 'This user has submitted both a file and an online syllabus. '+
                    'They have been notified that the online version is what will be reviewed, instead of the file. ' +
                    'The file can be <a href="'+fileSrc+'">downloaded here</a> anyway.';
                $('#subFileDownload').html(message);
            }
        } else {
            $('#subSyllabusView').text('N/A');
            $('#syllabusWordLink').text('');
            if (fileSrc) {
                $('#fileDownloadLink').attr('href', fileSrc).text(fileName);
            }
        }

        CKEDITOR.instances.subFeedback.setData(feedback);

        if (status == 'Approved') {
            $('#subStatus').text(status).addClass('text-success font-w900');
            $('#approveButton').show().val('Save Feedback');
            // $('#denyButton').val('Request Revisions Even Though Already Approved?').attr('name', `command[deny][${submissionId}]`);
            $('#denyButton').hide();
        } else {
            $('#subStatus').text(status).removeClass('text-success font-w900');
            $('#approveButton').show().val('Approve').attr('name', `command[approve][${submissionId}]`);    
            $('#denyButton').show().val('Request Revisions').attr('name', `command[deny][${submissionId}]`);
        }

    });

  });
})(jQuery);
