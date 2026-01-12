interface ContactProps {
  content: {
    title: string;
    description: string;
    address: string;
    email: string;
    phone: string;
    whatsapp: string;
  };
}

export default function Contact({ content }: ContactProps) {
  return (
    <section id="contact" className="py-20 relative text-white" style={{ 
      background: 'linear-gradient(180deg, rgba(192,22,175,0.59) 0%, rgba(150,60,140,1) 100%)',
      marginTop: '25px'
    }}>
      <div className="container mx-auto px-4">
        <div className="text-center mb-12">
          <h2 
            className="text-4xl md:text-5xl font-bold mb-4 uppercase" 
            style={{ 
              color: '#FFFFFF',
              fontFamily: 'Orbitron, sans-serif',
              fontWeight: 500,
              textShadow: '0 0 18px rgba(255, 255, 255, 0.8)',
              lineHeight: '38px'
            }}
          >
            {content.title}
          </h2>
          <p 
            className="text-xl max-w-2xl mx-auto" 
            style={{ 
              color: '#E4E7FF',
              fontFamily: 'Poppins, sans-serif',
              fontSize: '16px',
              fontWeight: 400
            }}
          >
            {content.description}
          </p>
        </div>
        
        <div className="grid md:grid-cols-3 gap-8 max-w-4xl mx-auto" style={{ marginTop: '25px' }}>
          {/* Address */}
          <div 
            className="flex flex-col items-center text-center rounded-lg p-6"
            style={{ 
              backgroundColor: '#1A1A2E',
              borderRadius: '10px',
              boxShadow: '0 0 10px rgba(0, 255, 255, 0.6), 0 0 20px rgba(0, 255, 255, 0.4), 0 0 40px rgba(0, 255, 255, 0.1)'
            }}
          >
            <a
              href={`https://wa.me/${content.whatsapp.replace(/\D/g, '')}`}
              target="_blank"
              rel="noopener noreferrer"
              className="mb-4 hover:scale-110 transition-transform"
              aria-label="Waze/Address"
              style={{ color: '#08F7FE' }}
            >
              <svg width="48" height="48" viewBox="0 0 512 512" fill="currentColor">
                <path d="M502.17 201.67C516.69 287.53 471.23 369.59 389 409.8c13 34.1-12.4 70.2-48.32 70.2a51.68 51.68 0 0 1-51.57-49c-6.44.19-64.2 0-76.33-.64A51.69 51.69 0 0 1 159 479.92c-33.86-1.36-57.95-34.84-47-67.92-37.21-13.11-72.54-34.87-99.62-70.8-13-17.28-.48-41.8 20.84-41.8 46.31 0 32.22-54.17 43.15-110.26C94.8 95.2 193.12 32 288.09 32c102.48 0 197.15 70.67 214.08 169.67zM373.51 388.28c42-19.18 81.33-56.71 96.29-102.14 40.48-123.09-64.15-228-181.71-228-83.45 0-170.32 55.42-186.07 136-9.53 48.91 5 131.35-68.75 131.35C58.21 358.6 91.6 378.11 127 389.54c24.66-21.8 63.87-15.47 79.83 14.34 14.22 1 79.19 1.18 87.9.82a51.69 51.69 0 0 1 78.78-16.42z"/>
              </svg>
            </a>
            <div className="whitespace-pre-line" style={{ color: '#E4E7FF' }}>{content.address}</div>
          </div>

          {/* Email */}
          <div 
            className="hidden md:flex flex-col items-center text-center rounded-lg p-6"
            style={{ 
              backgroundColor: '#1A1A2E',
              borderRadius: '10px',
              boxShadow: '0 0 10px rgba(0, 255, 255, 0.6), 0 0 20px rgba(0, 255, 255, 0.4), 0 0 40px rgba(0, 255, 255, 0.1)'
            }}
          >
            <a
              href={`mailto:${content.email}?subject=Request for information`}
              className="mb-4 hover:scale-110 transition-transform"
              aria-label="Email"
              style={{ color: '#08F7FE' }}
            >
              <svg width="48" height="48" viewBox="0 0 576 512" fill="currentColor">
                <path d="M160 448c-25.6 0-51.2-22.4-64-32-64-44.8-83.2-60.8-96-70.4V480c0 17.67 14.33 32 32 32h256c17.67 0 32-14.33 32-32V345.6c-12.8 9.6-32 25.6-96 70.4-12.8 9.6-38.4 32-64 32zm128-192H32c-17.67 0-32 14.33-32 32v16c25.6 19.2 22.4 19.2 115.2 86.4 9.6 6.4 28.8 25.6 44.8 25.6s35.2-19.2 44.8-22.4c92.8-67.2 89.6-67.2 115.2-86.4V288c0-17.67-14.33-32-32-32zm256-96H224c-17.67 0-32 14.33-32 32v32h96c33.21 0 60.59 25.42 63.71 57.82l.29-.22V416h192c17.67 0 32-14.33 32-32V192c0-17.67-14.33-32-32-32zm-32 128h-64v-64h64v64zm-352-96c0-35.29 28.71-64 64-64h224V32c0-17.67-14.33-32-32-32H96C78.33 0 64 14.33 64 32v192h96v-32z"/>
              </svg>
            </a>
            <div style={{ color: '#E4E7FF' }}>{content.email}</div>
          </div>

          {/* Phone */}
          <div 
            className="flex flex-col items-center text-center rounded-lg p-6"
            style={{ 
              backgroundColor: '#1A1A2E',
              borderRadius: '10px',
              boxShadow: '0 0 10px rgba(0, 255, 255, 0.6), 0 0 20px rgba(0, 255, 255, 0.4), 0 0 40px rgba(0, 255, 255, 0.1)'
            }}
          >
            <a
              href={`tel:${content.phone.replace(/\D/g, '')}`}
              className="mb-4 hover:scale-110 transition-transform"
              aria-label="Phone"
              style={{ color: '#08F7FE' }}
            >
              <svg width="48" height="48" viewBox="0 0 512 512" fill="currentColor">
                <path d="M497.39 361.8l-112-48a24 24 0 0 0-28 6.9l-49.6 60.6A370.66 370.66 0 0 1 130.6 204.11l60.6-49.6a23.94 23.94 0 0 0 6.9-28l-48-112A24.16 24.16 0 0 0 122.6.61l-104 24A24 24 0 0 0 0 48c0 256.5 207.9 464 464 464a24 24 0 0 0 23.4-18.6l24-104a24.29 24.29 0 0 0-14.01-27.6z"/>
              </svg>
            </a>
            <div style={{ color: '#E4E7FF' }}>{content.phone}</div>
          </div>
        </div>

        {/* Form Section */}
        <div 
          className="text-center mt-12 rounded-lg p-9"
          style={{ 
            backgroundColor: '#1A1A2E',
            borderRadius: '8px',
            boxShadow: '0 0 10px rgba(0, 255, 255, 0.6), 0 0 20px rgba(0, 255, 255, 0.4), 0 0 40px rgba(0, 255, 255, 0.1)',
            padding: '36px'
          }}
        >
          <h3 
            className="text-2xl font-bold mb-6 uppercase" 
            style={{ 
              color: '#FFFFFF',
              fontFamily: 'Orbitron, sans-serif',
              fontWeight: 500,
              textShadow: '0 0 18px rgba(255, 255, 255, 0.8)'
            }}
          >
            Contact us
          </h3>
          <p className="text-sm text-white/70 mb-6">Formulaire de contact à venir</p>
        </div>
      </div>
    </section>
  );
}
