interface GamesProps {
  content: {
    title: string;
    subtitle: string;
    items: Array<{
      name: string;
      description: string;
      video: string;
    }>;
  };
}

export default function Games({ content }: GamesProps) {
  return (
    <section id="games" className="py-20 relative" style={{ 
      background: 'linear-gradient(180deg, rgba(126,227,230,0.52) 0%, rgba(136,224,226,0.65) 100%)',
      borderRadius: '28px',
      boxShadow: '0px 0px 40px 0px rgba(0, 0, 0, 0.7)',
      marginTop: '25px',
      paddingTop: '3rem',
      paddingBottom: '3.2rem',
      paddingLeft: '2.2rem',
      paddingRight: '2.2rem'
    }}>
      <div className="container mx-auto px-4">
        <div className="text-center mb-12">
          <h2 
            className="text-4xl md:text-5xl font-bold mb-4 uppercase" 
            style={{ 
              color: '#FFFFFF',
              fontFamily: 'Orbitron, sans-serif',
              fontWeight: 500,
              textShadow: '0 0 18px rgba(255, 255, 255, 0.8)'
            }}
          >
            {content.title}
          </h2>
          <p className="text-lg max-w-2xl mx-auto" style={{ 
            color: '#FFFFFF',
            fontFamily: 'Poppins, sans-serif',
            fontSize: '16px',
            fontWeight: 400
          }}>
            {content.subtitle}
          </p>
        </div>
        
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          {content.items.map((game, index) => (
            <div 
              key={index} 
              className="rounded-2xl overflow-hidden transition-all duration-300 hover:-translate-y-2"
              style={{ 
                backgroundColor: '#05081EE6',
                borderRadius: '22px',
                boxShadow: '0 0 18px rgba(0, 0, 0, 0.8), 0 0 26px rgba(0, 0, 0, 0.6)',
                paddingTop: 0,
                paddingBottom: 0
              }}
            >
              <div className="relative aspect-video bg-black rounded-t-2xl overflow-hidden">
                <video
                  className="w-full h-full object-cover"
                  autoPlay
                  loop
                  muted
                  playsInline
                  style={{ borderRadius: '22px 22px 0 0' }}
                  poster={game.name === 'Control' ? '/videos/control-scaled.png' : undefined}
                >
                  <source src={game.video} type="video/mp4" />
                  Your browser does not support the video tag.
                </video>
              </div>
              <div className="p-6">
                <h3 
                  className="text-xl font-bold mb-3" 
                  style={{ 
                    color: '#F5F9FF',
                    fontFamily: 'Poppins, sans-serif',
                    fontSize: '1.05rem',
                    fontWeight: 600
                  }}
                >
                  {game.name}
                </h3>
                <p 
                  className="mb-4 leading-relaxed" 
                  style={{ 
                    color: '#CFD6FF',
                    fontFamily: 'Poppins, sans-serif',
                    fontWeight: 400
                  }}
                >
                  {game.description}
                </p>
                <button 
                  className="font-semibold transition-colors text-sm"
                  style={{ 
                    backgroundColor: 'transparent',
                    color: '#FF00E5',
                    fill: '#FF00E5'
                  }}
                >
                  More info →
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
