# Poptart

The gem used to consume the REST API provided by [Happiness Service](https://github.com/austenito/happiness_service)

# Usage

The gem provides ActiveRecord-y like models exposing service endpoint attributes.

## User

### Creating a user

```
user = User.create
user.service_user_id # => Some hash
```

## Authorization

Each request made by Poptart is made in the context of a service user id and
a user token. The service user id is the authentication token of a user 
stored in the happiness service. The user token is used for authorization of
a user and what survey information they have access to.

```
Poptart.authorize(
  service_user_id: service_user_id,
  user_token: token
)
```

## Question

### To find all questions
```
questions = Question.all
```

### Creating a question

```
Poptart::Question.create(
  'Do you like poptarts?',
   question_type: 'boolean',
   responses: [true, false],
   key: 'poptarts'
)
```

### Find a question

Questions can be found by id or key:

```
Poptart::Question.find(1)
Poptart::Question.find('what_are_you_doing')
```

## Surveys

### Creating a survey

By default, surveys are created with no questions.

```
Poptart::Survey.create
```

### Adding a question to a survey

```
survey_question = Poptart::SurveyQuestion.new('question_id' => 1)
survey.add_survey_question(survey_question)
```

### Find a specific survey question

```
Poptart::Survey.find(1)
```

### To find out if a survey has all of it's questions answered:

```
survey.completed?
```

## Survey Questions

### Find all survey questions

All survey questions can be found by the following keys:

* question_id
* key
* survey_id

This is useful to aggregate answers from multiple surveys.

```
Poptart::SurveyQuestion.find_all('what_are_you_doing')
```

# Answering a survey question

```
survey_question = survey.survey_questions.first
survey_question.answer = 'poptarts'
survey_question.submit
```
