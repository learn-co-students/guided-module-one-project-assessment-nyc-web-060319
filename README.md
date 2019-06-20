Module One Final Project
========================


---

## Goals (Minimum Requirements)


#### Setup

Before you start building, take a look at the files you have available in this repo.

* In the main directory, you've got a `Gemfile` that gives you access to `activerecord`, `pry`, `rake`, and `sqlite3`.
  * Remember to `bundle install`!
* In the `bin` directory, you've got a `run.rb` file that you can run from the command line with `ruby bin/run.rb.`
* In `config`, you've got your database set up with Active Record, as well as all of your models from the `lib` folder made available to your database.
* In the `lib` directory, you'll be building all your models.

**Note:** There is no `spec` directory. Your goal is to use [Behavior Driven Development (BDD)](https://en.wikipedia.org/wiki/Behavior-driven_development) to confirm that your code is doing what it should. This means instead of running `rspec` or `learn`, you should frequently be opening up the `rake console` and confirming that your methods and associations work.

---

### Phase 2: Scaffolding

This should take approximately **3/4 of a day**.

#### Data Models

Make a new file for each model in your `lib` folder. What's the naming convention for a model filename? Check out previous labs for a reminder. Remember that `activerecord` gem from our `Gemfile`? Make sure that every model inherits from `ActiveRecord::Base`.

Be sure to include the relationships between your models. The [Rails Guides ActiveRecord Documentation](http://guides.rubyonrails.org/association_basics.html) is a great source if you get stuck! Check out the `has_many :through` section when setting up your many-to-many relationship.

#### Migrations

---


#### Request - Input

#### Response - Output

#### CRUD IT UP!

---


#### Stretch Goals
* Use a `gem` to jazz up the look of our app with [ASCII text](https://github.com/miketierney/artii) or [colors](https://rubygems.org/gems/colorize/versions/0.8.1).

#### Robustness

While it's nice that we can use our app while following the [happy path](https://en.wikipedia.org/wiki/Happy_path), users aren't always so nice. Another opportunity for improvement would be to handle bad input or errors in a user friendly manner.

Find a way for your app to not break if a user inputs unexpected data. For example a restaurant name in ALL CAPS, or if their cat walks over the keyboard and enters "sfudihdsuifhsidu."

Can you think of any other scenarios? How would you gracefully handle such scenarios?

---

### Phase 6: Presentation

It's time to show off your creation to the world! Things you might want to do are:

* Write a README detailing:
  * How to install your application.
  * How to run your application.
  * How to use your application (commands that can be run).
  * What your program looks like (screenshots).
  * etc.
* Prepare a demo video describing how a user would interact with your working project.
    * The video should:
      * Have an overview of your project. (2 minutes max)
* Prepare a presentation to follow your video. (3 minutes max)
    * Your presentation should:
      * Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      * Discuss 3 things you learned in the process of working on this project.
      * Address, if anything, what you would change or add to what you have today?
      * Present any code you would like to highlight.
* Write a blog post about the project and process.

🎊 Good job on making to the end! 🎊
