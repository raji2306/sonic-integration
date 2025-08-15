import { render, screen } from '@testing-library/react';
import App from './App';

test('renders navbar with Home link', () => {
  render(<App />);
  const homeLink = screen.getByText(/home/i); // matches your navbar
  expect(homeLink).toBeInTheDocument();
});
