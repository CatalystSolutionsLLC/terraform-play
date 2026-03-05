const { app } = require('@azure/functions');

app.http('hello', {
    methods: ['GET'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        const environment = process.env.ENVIRONMENT || 'unknown';

        return {
            status: 200,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                message: `Hello from ${environment}!`,
                timestamp: new Date().toISOString(),
                environment: environment,
                version: "2.0"
            })
        };
    }
});