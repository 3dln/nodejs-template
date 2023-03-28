FROM node:18.13.0 as base

# Add package file
COPY package.json ./
COPY yarn.lock ./

# Install deps
RUN yarn

# Copy source
COPY src ./src
COPY tsconfig.json ./tsconfig.json
COPY openapi.json ./openapi.json

# Build dist
RUN yarn build

# Start production image build
FROM gcr.io/distroless/nodejs:18

# Copy node modules and build directory
COPY --from=base ./node_modules ./node_modules
COPY --from=base /dist /dist

# Copy static files
COPY src/public dist/src/public

# Expose port 8000
EXPOSE 8000
CMD ["dist/src/server.js"]