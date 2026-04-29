ARG NODESHA
ARG NODESHADEV
FROM reg.mini.dev/node@$NODESHADEV as builder

FROM reg.mini.dev/node@$NODESHA
