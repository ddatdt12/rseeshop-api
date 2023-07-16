# Book Reading Application

This repository contains a Ruby on Rails application that serves as a frontend service for a book reading platform. It provides users with a convenient interface to read books online and includes features such as book searching, book rating, and a recommender system.

## Technology Stack

- Ruby on Rails: A web application framework written in Ruby that follows the Model-View-Controller (MVC) architectural pattern.
- MySQL: A popular open-source relational database management system used for data storage.

## Features

### Book Reading

Users can search and select books from the available book catalog within the application. Once a book is chosen, users can read it online directly on the application. The application provides a user-friendly reading interface that allows users to navigate between pages, adjust font and text size, and enable/disable the night reading mode.

### Book Rating

Users can rate the books they have read on the application. The rating system typically uses a scale from 1 to 5 or can be represented through icons. Users can choose an appropriate score or symbol to express their rating. The user ratings are stored in the application's database and used for book recommendation purposes.

### Recommender System

The application utilizes a recommender system to suggest suitable books to users based on their rating history. When a user views the details of a book, the application displays a list of similar books using Content-based Filtering. These books have similar content, genres, authors, or keywords to the currently viewed book.

On the book detail page, the application also shows a category of related books using Item-based Filtering. This category is built based on books that have been similarly rated and are related to the current book.

On the homepage, a "Recommended for You" book list is displayed based on the user's rating history using User-based Filtering. The books in this list are suggested based on similarities to other users with similar preferences.

## Clone repository

   ```bash
   git clone https://github.com/ddatdt12/rseeshop-api.git
