import Translate, { translate } from '@docusaurus/Translate';
import Heading from '@theme/Heading';
import clsx from 'clsx';
import type { ReactNode } from 'react';
import styles from './styles.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: ReactNode;
};

const FeatureList = [
  {
    title: translate({
      message: 'Fast development',
      description: 'First feature title'
    }),
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <Translate
        id="homepage.features.speed.description"
        description="Quick to build and iterate"
      >
        Build endpoints quickly with Dart’s power. Our framework lets you
        focus on features, not boilerplate, so you can ship faster.
      </Translate>
    ),
  },
  {
    title: translate({
      message: 'Free & open source',
      description: 'Second feature title'
    }),
    Svg: require('@site/static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <Translate
        id="homepage.features.simple.description"
        description="Small and focused core"
      >
        Sarus is free, open-source, and constantly improving. You can host your server anywhere you can run Dart.
      </Translate>
    ),
  },
  {
    title: translate({
      message: 'Powered by Dart',
      description: 'Fourth feature title'
    }),
    Svg: require('@site/static/img/undraw_docusaurus_react.svg').default,
    description: (
      <Translate
        id="homepage.features.poweredbydart.description"
        description="Dart ecosystem benefits"
      >
        Take advantage of Dart’s modern language features, type safety, fast
        compilation, and rich tooling.
      </Translate>
    ),
  },
];


function Feature({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): ReactNode {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
