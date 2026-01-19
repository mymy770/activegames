import { Resend } from 'resend'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function test() {
  console.log('API Key exists:', !!process.env.RESEND_API_KEY)
  console.log('Key prefix:', process.env.RESEND_API_KEY?.substring(0, 10))
  
  const resend = new Resend(process.env.RESEND_API_KEY)
  
  try {
    const result = await resend.emails.send({
      from: 'ActiveGames <onboarding@resend.dev>',
      to: 'jeremy.music.music@gmail.com',
      subject: 'Test email',
      html: '<p>Test</p>',
    })
    console.log('Result:', result)
  } catch (err) {
    console.log('Error:', err)
  }
}
test()
