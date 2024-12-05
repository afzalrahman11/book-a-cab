module ValidationPatterns
  PHONE_REGEX = /\A[1-9]\d{9}\z/
  EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP
  PHONE_REGEX_MESSAGE = "must be a 10-digit number starting with a non-zero digit"
  EMAIL_REGEX_MESSAGE = "must be a valid email address"
end
