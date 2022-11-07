class SubmissionMailer < ApplicationMailer
  def send_submission_link(submission, manager, url)
    @submission = submission
    @manager = manager
    @url = url
    mail to: "imran.akhtar@brainxtech.com", subject: "New Form Submission Request"
  end

  def send_submission_status(submission, status, url)
    @submission = submission
    @status = status
    @url = url
    mail to: "i160016@nu.edu.pk", subject: "Submission #{status.titleize} "
  end
end
