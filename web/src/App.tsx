import React from 'react';
import { Activity, ArrowDown, Github, Award, Download, Users, Clock, Bed } from 'lucide-react';

function App() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white">
      <nav className="fixed w-full bg-white/80 backdrop-blur-md z-50 py-4 px-6">
        <div className="max-w-6xl mx-auto flex items-center justify-between">
          <div className="flex items-center">
            <Activity className="h-8 w-8 text-blue-600 mr-2" />
            <span className="text-2xl font-bold text-blue-600">MediQueue</span>
          </div>
          <a 
            href="https://github.com/PriDev07/MediQueue-hackVortex-2025"
            className="flex items-center text-gray-700 hover:text-blue-600 transition-colors"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Github className="h-6 w-6 mr-2" />
            View on GitHub
          </a>
        </div>
      </nav>

      <main>
        {/* Hero Section */}
        <section className="pt-32 pb-20 px-6">
          <div className="max-w-6xl mx-auto text-center">
            <div className="inline-flex items-center bg-blue-100 text-blue-600 px-4 py-2 rounded-full mb-8">
              <Award className="h-5 w-5 mr-2" />
              Hackathon Submission 2025 by Team CodeSavvy
            </div>
            <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
              Skip The Wait,<br />
              <span className="text-blue-600">Save Your Time</span>
            </h1>
            <p className="text-xl text-gray-600 mb-12 max-w-2xl mx-auto">
              MediQueue revolutionizes healthcare queue management with real-time updates, 
              virtual queuing, and bed availability tracking—all in one app.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center mb-16">
              <a 
                href="/web/src/assets/MediQueue.apk" 
                className="bg-blue-600 text-white px-8 py-4 rounded-xl font-medium hover:bg-blue-700 transition-colors flex items-center justify-center text-lg"
                download
              >
                <Download className="h-5 w-5 mr-2" />
                Download Android App
              </a>
              <a 
                href="#demo"
                className="border-2 border-gray-200 text-gray-700 px-8 py-4 rounded-xl font-medium hover:bg-gray-50 transition-colors flex items-center justify-center text-lg"
              >
                Watch Demo
              </a>
            </div>
            <ArrowDown className="h-8 w-8 text-gray-400 mx-auto animate-bounce" />
          </div>
        </section>

        {/* Stats Section */}
        <section className="py-16 bg-white px-6">
          <div className="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="bg-blue-50 p-8 rounded-2xl text-center">
              <Users className="h-10 w-10 text-blue-600 mx-auto mb-4" />
              <h3 className="text-4xl font-bold text-gray-900 mb-2">70%</h3>
              <p className="text-gray-600">Reduced Wait Time</p>
            </div>
            <div className="bg-blue-50 p-8 rounded-2xl text-center">
              <Clock className="h-10 w-10 text-blue-600 mx-auto mb-4" />
              <h3 className="text-4xl font-bold text-gray-900 mb-2">24/7</h3>
              <p className="text-gray-600">Real-time Updates</p>
            </div>
            <div className="bg-blue-50 p-8 rounded-2xl text-center">
              <Bed className="h-10 w-10 text-blue-600 mx-auto mb-4" />
              <h3 className="text-4xl font-bold text-gray-900 mb-2">100%</h3>
              <p className="text-gray-600">Bed Tracking Accuracy</p>
            </div>
          </div>
        </section>

        <section className="py-16 px-6">
          <div className="max-w-6xl mx-auto">
            <h2 className="text-3xl font-bold text-center mb-12">Built With Modern Tech Stack</h2>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
              <div className="bg-white p-6 rounded-xl shadow-sm text-center">
                <img 
                  src="https://storage.googleapis.com/cms-storage-bucket/4fd5520fe28ebf839174.svg" 
                  alt="Flutter" 
                  className="h-12 mx-auto mb-4"
                />
                <p className="font-medium">Flutter</p>
              </div>
              <div className="bg-white p-6 rounded-xl shadow-sm text-center">
                <img 
                  src="https://upload.wikimedia.org/wikipedia/commons/3/37/Firebase_Logo.svg" 
                  alt="Firebase" 
                  className="h-12 mx-auto mb-4"
                />
                <p className="font-medium">Firebase</p>
              </div>
              <div className="bg-white p-6 rounded-xl shadow-sm text-center">
                <img 
                  src="https://www.vectorlogo.zone/logos/nodejs/nodejs-ar21.svg" 
                  alt="Node.js" 
                  className="h-12 mx-auto mb-4"
                />
                <p className="font-medium">Node.js</p>
              </div>
              <div className="bg-white p-6 rounded-xl shadow-sm text-center">
                <img 
                  src="https://www.vectorlogo.zone/logos/expressjs/expressjs-ar21.svg" 
                  alt="Express" 
                  className="h-12 mx-auto mb-4"
                />
                <p className="font-medium">Express</p>
              </div>
            </div>
          </div>
        </section>

        <section id="demo" className="py-16 px-6 bg-gray-50">
  <div className="max-w-4xl mx-auto text-center">
    <h2 className="text-3xl font-bold mb-12">See MediQueue in Action</h2>
    <div className="aspect-video bg-gray-200 rounded-2xl mb-8 flex gap-4 p-4 justify-center">
      <img 
        src="https://i.ibb.co/WJ4qRgq/Untitled-design-1-removebg-preview.png" 
        alt="Screenshot 1" 
        className="object-contain rounded-lg" 
      />
      <img 
        src="https://i.ibb.co/f5jXgnT/Screenshot-2025-05-30-at-3-57-04-PM-removebg-preview.png"
        alt="Screenshot 2" 
        className="object-contain rounded-lg" 
      />
      <img 
        src="https://i.ibb.co/RkXwqF7v/Screenshot-2025-05-30-at-4-03-02-PM-removebg-preview.png" 
        alt="Screenshot 3" 
        className="object-contain rounded-lg"
      />
    </div>
  </div>
</section>
        <footer className="py-8 px-6 bg-white border-t">
          <div className="max-w-6xl mx-auto text-center text-gray-600">
            <p>Created by Team CodeSavvy for HackVortex 2025</p>
          </div>
        </footer>
      </main>
    </div>
  );
}

export default App;