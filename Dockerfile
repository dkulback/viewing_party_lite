# Base image
FROM ruby:2.7.7

# Install dependencies
RUN apt-get update && \
    apt-get install -y postgresql-client nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.2.26 && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]
