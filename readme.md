# The Web-based DVR App Prototype

We will be going thru a full, but abbreviated, product development cycle for a "proof-of-concept" app. The product is a DVR with a web interface, that will allow multiple users to control what's being recorded!

In order to build our DVR, we are going to work with two [_libraries_<sup>1</sup>](#our-libraries), one that "tunes in" to the TV broadcast (`Tuner`) and one that streams a broadcast to a viewer thru an HTML5 widget (`Streamcast`). These libraries, as any outside libraries you add to your application, should exist in a `/vendor` folder within your app's root. They are included here in their own vendor directory (you can copy it over wholesale).

Also, when working in development mode, we have a test dataset to represent a TV schedule. That dataset should be translated into a `db/seeds.rb` file. You can assume that this dataset will be updated in the future, but that building the schedule data update process will not be part of our MVP.

## The Idea

You're at a networking event in DUMBO. While there, an *investor/CEO/client/Wharton student* approaches you with an idea. The pitch goes like this:

> So, you log in to the website. From there you can
> either choose to see a list of saved episodes, a list
> of scheduled recordings, or a schedule of all TV shows.
> When you go to the list of saved episodes you can watch
> a recording or delete it. From the list of upcoming
> recordings, you can edit or remove recording
> preferences (like which shows you want to record,
> basically). From the TV schedule, you can a list of
> upcoming shows like a TV guide or something, and you
> can navigate thru it. The shows look different if
> they're set to be recorded or not. If you click on a
> show you aren't currently set to record, you can create
> a new recording.

You are skeptical, but they agree to pay you a set fee for a prototype. They write you a personal check on the spot. You have one weekend.

**Good Luck!**

## The Lab

### Prologue: Teams

**Outcome(s)**:
- groups of four (two pairs), and
- a designated "project manager" (**repo manager**), and
- a repo on GitHub, and
- a project on Trello.

**Length**:
- 1 pomodoro

You can see the prompt, and we (the instructors) will apportion you into groups of four. You can decide who will host the project repo, but make us and all teammates collaborators on it.

The repo must be named: `dvr_app`. The Trello project should also be called somethign like `dvr_app`, but that isn't necessary.

All members of the team should clone the repo and work in branches named after themselves

### Part I: [Inception](inception) (Planning)

**Outcome(s)**:
- a data model (in the form of an ERD),
- a wireframe for the website, and
- a set of user stories for features.

**Length**:
- 4 pomodoros

You should split into two pairs, one focusing on the wireframes, and one looking over the dataset and making decisions about how things work. Work for one pomodoro apart, and then come together and develop an ERD in concert for a pomodoro.

The final two pomodoros involve adding user stories to Trello and finalizing an ERD.

At this point there is a hard stop. We will come together and discuss the ideas you have had with your groups. Moving forward, we will all receive a single, class-wide ERD, wireframe and set of user stories to work with. Sorry, but then otherwise there'd be no way to share a meaningful solution.

### Part II: Sprint Planning

**Outcome(s)**:
- a set of features that comprise MVP,
- a subset of those features to be completed in the first (in-class) sprint,
- a Trello board that assigns those features to the two pairs with in the group.

**Length**:
- 1.5 pomodoros

Decide who the two pairs will be. A suggestion (you in no way have to follow) is to have one group work more directly with the data and getting the data into the database, and the other scaffold up a Sinatra app with all of the necessary parts (libraries, Sequel, Postgres, etc.) and then start building routes. It may make sense to have the project manager to be working with the data, since that may involve a less formal commit process.

And then we lunch.

### Part III: In-class Sprint

**Outcome(s)**:
- some set of features for a real application,
- a code review, and
- a retrospective (with the notes posted in Trello).

**Length**:
- 1:30pm - 5:00pm

Break the day into pomodoros, with five minute breaks three times followed by a fifteen minute break. Keep track of the work done. Commit often.

The last 30 minutes of day will be a retro, in which we attempt to talk about the process and how it worked. These will be internal to each group, and the outcome of the retro will be posted on the Trello board.

## The Weekend Homework

**Outcome(s)**:
- (ideally) some subset of features for a real application that can be called an MVP!

**You can mix and match, switch groups, work alone, etc.** You are not bound by the group you worked with in the lab! You can always fork the project!

If you are working together, you should have "stand-ups" either with HipChat (ask and we can make you a room) or IRL.

## Monday

We will do code reviews and begin working on tests to ensure that our features work correctly (**Capybara**), and that our "business logic" is encapsulated correctly in our models (**Rspec**).

<!-- Links -->

[inception]: http://pivotallabs.com/agile-inception_knowing-what-to-build-and-where-to-start/

---
## Addenda

### Our "Libraries"

Number one: *they aren't real libraries!* But that doesn't matter. All that matters is that they are modules, classes, etc., **and therefore have an interface**.

Just as in every situation you will find yourself in as a developer, you won't be delivering a service from top to bottom: you are going to redirect some inputs and outputs from libraries, bake in your app's "business logic," and use some specific dataset as it's given to you. Putting all of these things together is the name of the game.

##### Tuner

Requiring and then calling `Tuner#record`, as below, will return a "bit stream" that represents the incoming data of recording channel 3 for 60 minutes, starting now, and store it in a file.

```ruby
f = File.new('fname.prog', 'w+')
t = Tuner.new
f.write(t.record(3, 60))
```

That data should be stored in a folder named `/recordings` as a file with the name:

```bash
recordings/program_id-episode_id-time_start-length.prog
```

And the name of that file should also be saved in the database, so that you can reference that file later.

##### Streamcast

Calling:
```ruby
Streamcast::HTML.embed_video(:small, recording_file_stream)
```

... should return a string that embeds a video in HTML, given that the first value is either `:small`, `:medium`, `:large`, or `:fullscreen`, and the second points to a **file stream** for a viable recording saved by the `Tuner` class.
