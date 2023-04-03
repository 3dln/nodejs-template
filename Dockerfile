FROM node:18-alpine as base

# Add package file
COPY package.json ./
COPY yarn.lock ./

# Install deps
RUN yarn

# Copy source
COPY src ./src
COPY tsconfig.json ./tsconfig.json

# Build dist
RUN yarn build

# Start production image build
FROM node:18-alpine

# Copy node modules and build directory
COPY --from=base ./node_modules ./node_modules
COPY --from=base /dist /dist

# Expose port 8000
EXPOSE 8000
CMD ["dist/server.js"]