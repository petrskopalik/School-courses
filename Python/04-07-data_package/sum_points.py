import argparse
import json
import pathlib

from data.dataframe import DataFrame


path = pathlib.Path.cwd().joinpath("results")
res = {}

for file in path.glob("*/*.csv"):
    dataframe = DataFrame.from_csv(file)

    for col, series in zip(dataframe.index.labels[1:], dataframe.values[1:]):
        points = sum(1 for val in series.values if val == "1")

        if col in res:
            res[col] += points
        else:
            res[col] = points

parser = argparse.ArgumentParser()
parser.add_argument("--output", help="Cílový soubor")
args = parser.parse_args()

with open(args.output, "w") as file:
    file.write(json.dumps(res))