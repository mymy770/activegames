interface PricingProps {
  content: {
    title: string;
    description: string;
  };
}

export default function Pricing({ content }: PricingProps) {
  const lines = content.description.split('\n').filter(line => line.trim());
  
  return (
    <section id="price" className="py-20 relative text-white" style={{ 
      background: 'linear-gradient(180deg, rgba(126,227,230,0.52) 0%, rgba(136,224,226,0.65) 100%)',
      borderRadius: '28px',
      boxShadow: '0px 0px 40px 0px rgba(0, 0, 0, 0.7)',
      marginTop: '25px',
      paddingTop: '3rem',
      paddingBottom: '3.2rem',
      paddingLeft: '2.2rem',
      paddingRight: '2.2rem'
    }}>
      <div className="container mx-auto px-4 text-center">
        <h2 
          className="text-4xl md:text-5xl font-bold mb-8 uppercase" 
          style={{ 
            color: '#FFFFFF',
            fontFamily: 'Orbitron, sans-serif',
            fontWeight: 600,
            textShadow: '0 0 18px rgba(255, 255, 255, 0.8)'
          }}
        >
          {content.title}
        </h2>
        <div className="max-w-4xl mx-auto space-y-6 text-left">
          {lines.map((line, index) => {
            if (line.trim().startsWith('•')) {
              return (
                <p 
                  key={index} 
                  className="text-lg pl-6"
                  style={{ 
                    color: '#E4E7FF',
                    fontFamily: 'Roboto, sans-serif',
                    fontSize: '29px',
                    fontWeight: 500
                  }}
                >
                  {line.trim().substring(1).trim()}
                </p>
              );
            }
            if (line.trim().match(/^[A-Z]/) || line.includes('₪')) {
              return (
                <p 
                  key={index} 
                  className="text-xl md:text-2xl font-semibold"
                  style={{ 
                    color: '#E4E7FF',
                    fontFamily: 'Roboto, sans-serif',
                    fontSize: '29px',
                    fontWeight: 500
                  }}
                >
                  {line.trim()}
                </p>
              );
            }
            return (
              <p 
                key={index} 
                className="text-lg"
                style={{ 
                  color: '#E4E7FF',
                  fontFamily: 'Roboto, sans-serif',
                  fontSize: '29px',
                  fontWeight: 500
                }}
              >
                {line.trim()}
              </p>
            );
          })}
        </div>
      </div>
    </section>
  );
}
