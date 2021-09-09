<div align="center">
  <a href=https://github.com/Turing-Project-Manager/CodeHerdAPI/graphs/contributors><img src="https://img.shields.io/github/contributors/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge" /></a>
  <a href=https://github.com/Turing-Project-Manager/CodeHerdAPI/network/members><img src="https://img.shields.io/github/forks/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge" /></a>
  <a href=https://github.com/Turing-Project-Manager/CodeHerdAPI/stargazers><img src="https://img.shields.io/github/stars/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge" /></a>
  <a href=https://github.com/Turing-Project-Manager/CodeHerdAPI/issues><img src="https://img.shields.io/github/issues/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge" /></a>
  <img src=https://circleci.com/gh/Turing-Project-Manager/CodeHerdAPI.svg?style=svg />
</div>

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://codeherd.herokuapp.com/">
    <img src="https://github.com/Turing-Project-Manager/CodeHerd/blob/main/src/assets/elephant.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">CodeHerdAPI</h3>

  <p align="center">
    A place to corral all things project related into one central location.  
    <br />
    <br />
    <a href="https://codeherdapi.herokuapp.com/"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://codeherd.herokuapp.com/">View Demo</a>
    ·
    <a href="https://github.com/Turing-Project-Manager/CodeHerdAPI/issues">Report Bug</a>
    ·
    <a href="https://github.com/Turing-Project-Manager/CodeHerdAPI/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a>
      <ul>
        <li><a href="#project-links">Project Links</a></li>
      </ul>
      <ul>
        <li><a href="#backend">Backend</a></li>
      </ul>
      <ul>
        <li><a href="#frontend">Frontend</a></li>
      </ul>
    </li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Welcome to CodeHerdAPI! This is the backend application for CodeHerd, a One-App-To-Rule-Them-All approach for Turing students to organize their projects.   

With CodeHerd, searching Slack high and low for that one link to that great resource a peer shared or remembering which of the 50 open tabs is the project requirements will be a thing of the past.  CodeHerd gives Turing students one central location for all things project related.  

To start, a student will sign into CodeHerd using GitHub authorization. From there they can create a project and begin to gather and store all the information they could ever want.  With their GitHub account already accessible, it's as easy as pie to link a repository to the project they've created.  The student can even hand over the reigns, so to speak, by adding collaborators to their project.  Once added, a collaborator can contribute to the project by adding links to helpful resources and any necessary documentation; they'll also have access to DTR templates, pull request templates, and much more.  

The best thing?  The student will have their body of work in one place to find a resource that can help on a future project or determine which two or three projects are perfect to show off their radical coding skills on their resume.  We know CodeHerd holds the promise of becoming a robust application to answer the needs of Turing students.  This is just the first iteration after all!  

### Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [GraphQL Ruby](https://graphql-ruby.org/)
* [Omniauth](https://github.com/omniauth/omniauth)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

* You'll need to create the Github Key and Secret by creating a Github OAuth app. https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app

### Installation

1. Clone the repo
   ```rb
   git clone https://github.com/Turing-Project-Manager/CodeHerdAPI.git
   ```
2. Install gems
   ```rb
   bundle install
   ```
3. Install figaro
   ```rb
   bundle exec figaro install
   ```
4. In `application.yml` file add the following keys under the exact names:
   ```rb
   GitHub key as `GITHUB_KEY`
   GitHub secret as `GITHUB_SECRET`
   CORS origin as `CORS_ORIGINS`
    This ENV VAR is to set the allowed origins for CORS
   ```
5. Run `rails db:{create,migrate}`


<!-- USAGE EXAMPLES -->
## Usage

_For more examples, please refer to: [GraphQL Queries & Mutations](https://codeherdapi.herokuapp.com/)_

<!-- #### Generate Graphql docs

make sure you download the npm package graphdocs npm install -g @2fd/graphdoc

you'll need to start a local server or ping the deployed. This will put the files in the public folder for rails to serve

```
graphdoc -e http://localhost:3000/graphql -o ./public
``` -->

<!-- ROADMAP -->
## Roadmap

See the [open issues](issues-url) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Do you have an idea to take CodeHerdAPI to the next level?  Rad!!  We want to see!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- CONTACT -->
## Contact

#### Back-End Team:

* Taija Warbelow - [Linkedin](https://www.linkedin.com/in/taija-warbelow/) - [GitHub](https://github.com/twarbelow) - taija.warbelow@gmail.com

* Zach Green - [Linkedin](https://www.linkedin.com/in/zachjamesgreen/) - [GitHub](https://github.com/zachjamesgreen) - zachjamesgreen@gmail.com

* Leigh Cepriano Pulzone - [Linkedin](https://www.linkedin.com/in/lcpulzone/) - [GitHub](https://github.com/lcpulzone) - lcpulzone@gmail.com

#### Front-End Team:

* Shawn McMahon - [Linkedin](https://www.linkedin.com/in/shawnpmcmahon/) - [GitHub](https://github.com/shawnmcmahon) - shawnmcmahon17@gmail.com

* Ashton Huxtable - [Linkedin](https://www.linkedin.com/in/ashtonhuxtable/) - [GitHub](https://github.com/ashton-huxtable) - aehuxtable@gmail.com

#### Project Links:

* Organization Link: [Turing Project Manager](https://github.com/Turing-Project-Manager)

* BE Project Link: [CodeHerdAPI](https://github.com/Turing-Project-Manager/CodeHerdAPI)

* FE Project Link: [CodeHerd](https://github.com/Turing-Project-Manager/CodeHerd)




<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [README Template Source](https://github.com/othneildrew/Best-README-Template)
* [Turing Requirements](https://mod4.turing.edu/projects/capstone/)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge
[contributors-url]: https://github.com/Turing-Project-Manager/CodeHerdAPI/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge
[forks-url]: https://github.com/Turing-Project-Manager/CodeHerdAPI/network/members
[stars-shield]: https://img.shields.io/github/stars/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge
[stars-url]: https://github.com/Turing-Project-Manager/CodeHerdAPI/stargazers
[issues-shield]: https://img.shields.io/github/issues/Turing-Project-Manager/CodeHerdAPI.svg?style=for-the-badge
[issues-url]: https://github.com/Turing-Project-Manager/CodeHerdAPI/issues
