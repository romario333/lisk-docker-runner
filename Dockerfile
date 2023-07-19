FROM node:18-slim AS base

FROM base AS deps
WORKDIR /app

# install dependencies
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install

FROM base AS runner
WORKDIR /app

RUN addgroup --system --gid 1001 agorapp
RUN adduser --system --uid 1001 agorapp

COPY . .

COPY --from=deps --chown=agorapp:agorapp /app/node_modules ./node_modules
RUN mkdir userspace && chown agorapp:agorapp userspace

USER agorapp
ENV NODE_ENV production
CMD [ "node_modules/.bin/ts-node", "src/main.ts" ]
