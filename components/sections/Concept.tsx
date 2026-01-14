interface ConceptProps {
  content: {
    title: string;
    description: string;
  };
}

export default function Concept({ content }: ConceptProps) {
  return (
    <section id="concept" className="py-20 relative" style={{ background: 'linear-gradient(180deg, rgba(192,22,175,0.59) 0%, rgba(150,60,140,1) 100%)' }}>
      <div className="container mx-auto px-4">
        <div className="max-w-5xl mx-auto">
          <h2 
            className="text-4xl md:text-5xl font-bold text-center mb-12 uppercase" 
            style={{ 
              color: '#FFFFFF',
              fontFamily: 'Orbitron, sans-serif',
              fontWeight: 500,
              textShadow: '0 0 18px rgba(255, 255, 255, 0.8)'
            }}
          >
            {content.title}
          </h2>
          <div className="prose prose-lg max-w-none">
            <div className="leading-relaxed space-y-4" style={{ 
              color: '#E4E7FF',
              fontFamily: 'Poppins, sans-serif',
              fontSize: '16px',
              fontWeight: 400
            }}>
              {content.description.split('\n\n').map((paragraph, index) => (
                paragraph.trim() && (
                  <p key={index} className="mb-4" style={{ marginBlockEnd: 0 }}>
                    {paragraph.trim()}
                  </p>
                )
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
