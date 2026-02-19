FROM node:20

# Enable corepack (ships with Node 20)
RUN corepack enable

WORKDIR /app

# Copy lock + package files first
COPY package.json pnpm-lock.yaml* ./

# Install pnpm via corepack
RUN corepack prepare pnpm@latest --activate

# Install dependencies
RUN pnpm install

# Copy rest of source
COPY . .

# Build
RUN pnpm build

# Run agent
CMD ["node", "dist/index.js", "--run"]