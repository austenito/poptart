# Poptart

The gem used to consume the REST API provided by [Happiness Service](https://github.com/austenito/happiness_service)

# Usage

The gem provides ActiveRecord-y like models exposing service endpoint attributes.

## User

To create a user:

```
user = User.create
user.service_user_id # => <Some hash>
```

Users have a 1-many relationship to `surveys`. A user has read/write access to surveys as such:

```
user.create_survey
user.create_random_survey
user.survey_for_id(id)

```


## Question

To find all questions:
```
questions = Question.all

```

## Surveys

To add a question to a survey:

```
question = Question.all.first
survey.add_question(question)
```

To find out if a survey has all of it's questions answered:

```
survey.completed?
```

## Survey Questions

To answer a survey question:

```
survey_question = survey.survey_questions.first
survey_question.answer = 'poptarts'
survey_question.submit
```
