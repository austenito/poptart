# Poptart

The gem used to consume the REST API provided by [Happiness Service](https://github.com/austenito/happiness_service)

# Usage

The gem provides ActiveRecord-y like models exposing service endpoint attributes.

## User

To create a user:

```
user = User.create(14)
user.id # => 14
```

Users have a 1-many relationship to `surveys`. A user has read/write access to surveys as such:

```
user.create_survey
user.create_random_survey
user.survey_for_id(id)
user.survey_for_url #=> Do I want to get rid of this?
```


