# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
# encoding: utf-8
Product.delete_all
Product.create!(title: 'Biggest Book For Dummies',
                description:
                    %{<p>
      <em>Powerful, Effective, and Efficient Full-Stack Web Development</em>
      As a Rails developer, you care about user experience and performance,
      but you also want simple and maintainable code. Achieve all that by
      embracing the full stack of web development, from styling with
      Bootstrap, building an interactive user interface with AngularJS, to
      storing data quickly and reliably in PostgreSQL. Big stuff.
      </p>},
                image_url: 'dcbang.jpg',
                price: 420.00)
# . . .
Product.create!(title: 'Junior Dev Performance Optimization',
                description:
                    %{<p><em>Why You're Slow, and How to Fix It</em>Check yourself before you wreck yourself.</p>},
                image_url: '7apps.jpg',
                price: 99.00)
# . . .

Product.create!(title: 'Possess Mind Control',
                description:
                    %{<p>Just when you thought you didn't need more books.</p>},
                image_url: 'adrpo.jpg',
                price: 64.00)
