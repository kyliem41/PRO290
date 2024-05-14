const amqp = require('amqplib')
const nodemailer = require('nodemailer')

const EMAIL = process.env.EMAIL
const PASSWORD = process.env.PASSWORD

async function email_consumer() {
    try {
        console.log(EMAIL)
        console.log(PASSWORD)
        // Connect to RabbitMQ
        const url = process.env.RABBIT_URL || 'amqp://localhost';
        const connection = await amqp.connect(url)
        const channel = await connection.createChannel()
    
        // Declare the email queue
        const emailQueue = 'email_queue'
        await channel.assertQueue(emailQueue, { durable: true })
    
        // Process messages from the email queue
        console.log('Email service is listening for messages...')
        channel.consume(emailQueue, async (message) => {
            console.log(message.content.toString())
            try {
                let email_data = JSON.parse(message.content.toString())

                //init object to send email 
                const transporter = nodemailer.createTransport({
                    service: 'Gmail',
                    auth: {
                        user: EMAIL,
                        pass: PASSWORD
                    }
                })

                //init data for email
                const mail_options = {
                    from: EMAIL,
                    to: email_data.email,
                    subject: email_data.subject,
                    text: email_data.message
                }

                //send email
                transporter.sendMail(mail_options, (err) => {
                    if (err) {
                        console.log(err)
                    } 
                })
            
                // Acknowledge the message
                channel.ack(message)
                console.log('Email sent successfully')
            } 
            catch (error) {
                console.error('Error sending email:', error)
                // Negative acknowledge the message
                channel.nack(message)
            }
        })
    }
    catch (error) {
        console.error('Error:', error)
    }
}

email_consumer()