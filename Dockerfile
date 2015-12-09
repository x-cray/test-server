FROM registry.local/nodejs

ENV NODE_ENV production
ADD server.js /app/

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["node", "/app/server.js"]
