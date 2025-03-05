# Use official Deno image
FROM denoland/deno:1.40.4 AS builder

WORKDIR /app
COPY deno.json* import_map.json* ./
RUN deno cache --import-map=import_map.json deps.ts

# Final lightweight production image
FROM denoland/deno:1.40.4

WORKDIR /app
COPY --from=builder /deno-dir /deno-dir
COPY . .

EXPOSE 8000

CMD ["deno", "run", "--allow-net", "--import-map=import_map.json", "index.ts"]
