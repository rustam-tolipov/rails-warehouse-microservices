# Dockerfile

FROM ruby:3.3.1

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install bundler
RUN gem install bundler

# Copy Gemfiles and install gems
COPY Gemfile* ./
RUN bundle install

# Copy the full app
COPY . .

# Precompile or prepare (skip assets since API-only)
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p 3000"]
