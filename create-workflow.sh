#!/bin/bash
PARALLEL_COUNT=$1
WORKFLOW_FILENAME=$(echo ".cloudbees/workflows/$2.yaml")
START=1

echo $PARALLEL_COUNT
echo $WORKFLOW_FILENAME

echo "apiVersion: automation.cloudbees.io/v1alpha1" > $WORKFLOW_FILENAME
echo "kind: workflow" >> $WORKFLOW_FILENAME
echo "name: My automation" >> $WORKFLOW_FILENAME
echo "" >> $WORKFLOW_FILENAME
echo "on:" >> $WORKFLOW_FILENAME
echo "  push:" >> $WORKFLOW_FILENAME
echo "    branches:" >> $WORKFLOW_FILENAME
echo "      - '**'" >> $WORKFLOW_FILENAME
echo "" >> $WORKFLOW_FILENAME
echo "jobs:" >> $WORKFLOW_FILENAME
for i in $(eval echo "{$START..$PARALLEL_COUNT}")
do
  echo "  job$(printf %05d $i):" >> $WORKFLOW_FILENAME
  echo "    steps:" >> $WORKFLOW_FILENAME
  echo "      - name: Say hello" >> $WORKFLOW_FILENAME
  echo "        uses: docker://golang:1.20.3-alpine3.17" >> $WORKFLOW_FILENAME
  echo "        shell: sh" >> $WORKFLOW_FILENAME
  echo "        run: |" >> $WORKFLOW_FILENAME
  echo "          echo \"sleeping for 180\"" >> $WORKFLOW_FILENAME
  echo "          sleep 180" >> $WORKFLOW_FILENAME
  echo "          echo \"done\"" >> $WORKFLOW_FILENAME
done
echo "  job999999:" >> $WORKFLOW_FILENAME
echo "    steps:" >> $WORKFLOW_FILENAME
echo "      - name: Say hello" >> $WORKFLOW_FILENAME
echo "        uses: docker://golang:1.20.3-alpine3.17" >> $WORKFLOW_FILENAME
echo "        shell: sh" >> $WORKFLOW_FILENAME
echo "        run: |" >> $WORKFLOW_FILENAME
echo "          echo \"\$(date)\"" >> $WORKFLOW_FILENAME
echo "          echo \"done\"" >> $WORKFLOW_FILENAME
echo "    needs:" >> $WORKFLOW_FILENAME
for i in $(eval echo "{$START..$PARALLEL_COUNT}")
do
  echo "      - job$(printf %05d $i)" >> $WORKFLOW_FILENAME
done