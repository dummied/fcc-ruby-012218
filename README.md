# Introduction to Ruby (and Rails)

Hi. For this workshop, we're going to be playing around with some data.
In this case, [538](http://fivethirtyeight.com/)'s Avengers (comic book) history data (available
[here](https://github.com/fivethirtyeight/data/tree/master/avengers)).

## Getting started

### Installing Ruby

If you're on a Mac, feel free to move along here. Ruby - and many of the
other bits of this - come standard on Macs!

For you Windows folks, I've had great luck with this installer: <https://rubyinstaller.org/>. For our purposes, I'd recommend [Ruby 2.4.3-1 (x64)](https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.4.3-1/rubyinstaller-2.4.3-1-x64.exe), but you do you.

For the purposes of this workshop, you're also going to need sqlite3 - a
lightweight database library. You can find downloads [here](https://www.sqlite.org/download.html). I haven't tried it, but I'd be inclined to give the [64-bit version](https://www.sqlite.org/2018/sqlite-dll-win64-x64-3220000.zip) a shot.

If you're on Linux ... I'm going to assume you know what you're doing.

### Getting the initial app

If you have git installed, you can find the git repo here <https://github.com/dummied/fcc-ruby-012218> and
are a `git clone https://github.com/dummied/fcc-ruby-012218.git` away.

If not, you'll need to download the project - you should be able to find
a link for that on GitHub as well.

### One more thing

`gem install bundler` from the command line.

Then, `cd` into the project directory you just cloned or downloaded.

### Installing the gems

Ruby calls its software packages "gems" (to be fair: Python calls theirs
"eggs", so funny names are kind of a thing). `bundler`, the package we
just installed, helps manage those dependencies for Ruby applications.

From the project root, run:

`bundle install`

To install all the libraries we need.

### Loading the data

`bundle exec rake db:seed`

You should see a slew of `#<CSV::Row` fly by on your screen.

## Playing with data

For this first part (or second depending on how the previous went),
we're going to use an interactive Ruby prompt to explore the data we
just loaded a bit.

`rails console`

`#protip`: Programmers in general are lazy, and Rubyists are a
particularly (and specifically) lazy breed, so `rails c` does the same
as the above.

You should see something like the below:

```
Running via Spring preloader in process 31199
Loading development environment (Rails 4.2.6)
[1] pry(main)>
```

If this is your first exposure to Ruby, we'll get "Hello World" out of
the way:

`puts "Hello World!"`

Well now, that was easy.

We've loaded our CSV of data into a SQLite3 database and created a few
objects to represent those.

Since we're inside a Rails application (more on that later), we can use
ActiveRecord to query that data.

For instance, if we want to know how many Avengers there are:

`Avenger.count`

Let's take a closer look at our first Avenger:

`avenger = Avenger.first`

You should get back something like:

```
 Avenger Load (0.9ms)  SELECT  "avengers".* FROM "avengers"  ORDER BY "avengers"."id" ASC LIMIT 1
=> #<Avenger:0x007f95020b48b8
 id: 1,
 name: "Henry Jonathan \"Hank\" Pym",
 appearances: 1269,
 current: true,
 gender: "male",
 honorary: false,
 notes: "Merged with Ultron in Rage of Ultron Vol. 1. A funeral was held.",
 alive: false,
 died_times: 1,
 return_times: 0,
 wiki_url: "http://marvel.wikia.com/Henry_Pym_(Earth-616)",
 created_at: Wed, 06 Jul 2016 19:39:16 UTC +00:00,
 updated_at: Wed, 06 Jul 2016 19:39:16 UTC +00:00,
 year: 1963>
```

Good ol' Hank Pym. What ActiveRecord does is turn methods into database
queries and the returns of those queries in Ruby objects.

In this case, our Avenger objects have methods we can call on them such
as: `name`, `notes`, `died_times`, `year`.

For instance, if we wanted our Avenger's name:

`avenger.name`

Play around a bit with the other methods.

Now, let's see how many Avengers have died at least once:

`Avenger.where("died_times > 0").count`

How about how many have, you know, stayed dead (this is comic books
after all)?

`Avenger.where("died_times > return_times").count`

How many women?

`Avenger.where(gender: "female").count`

Now, try finding out how many male Avengers there have been ...

## Playing with CRUD

Type `exit` to get out of the console.

Let's do `rails server` instead.

`#protip` - `rails s` works, too

Now, visit <http://localhost:3000>
